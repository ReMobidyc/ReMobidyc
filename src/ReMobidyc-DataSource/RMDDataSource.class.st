Class {
	#name : #RMDDataSource,
	#superclass : #Object,
	#instVars : [
		'originalDataFrame',
		'dataFrame',
		'units',
		'interpolations',
		'lastIndex',
		'cycle'
	],
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDDataSource class >> dataFrame: aDataFrame [

	^ self new
		  dataFrame: aDataFrame;
		  yourself
]

{ #category : #accessing }
RMDDataSource class >> readFromCsv: aFileReference [

	^ self dataFrame: (DataFrame readFromCsv: aFileReference)
]

{ #category : #accessing }
RMDDataSource >> atTime: aNumber [

	| t index data0 data1 data |
	t := cycle ifNil: [ aNumber ] ifNotNil: [ aNumber \\ cycle ].
	index := self indexAtTime: t.
	data0 := (dataFrame rowAt: index) asDictionary.
	data1 := (dataFrame rowAt: index + 1) asDictionary.
	data := Dictionary new.
	data0 keysDo: [ :name |
		data at: name put: (name = 'time'
				 ifTrue: [ aNumber ]
				 ifFalse: [
					 (self interpolationAt: name)
						 atTime: t
						 at: name
						 between: data0
						 and: data1 ]) ].
	^ data
]

{ #category : #accessing }
RMDDataSource >> atTime: aNumber at: aString [

	| t index data0 data1 |
	t := cycle ifNil: [ aNumber ] ifNotNil: [ aNumber \\ cycle ].
	index := self indexAtTime: t.
	data0 := (dataFrame rowAt: index) asDictionary.
	data1 := (dataFrame rowAt: index + 1) asDictionary.
	^ aString = 'time'
		  ifTrue: [ aNumber ]
		  ifFalse: [
			  (self interpolationAt: aString)
				  atTime: t
				  at: aString
				  between: data0
				  and: data1 ]
]

{ #category : #accessing }
RMDDataSource >> cycle [

	^ cycle
]

{ #category : #accessing }
RMDDataSource >> cycle: aNumberOrNil [

	cycle := aNumberOrNil
]

{ #category : #accessing }
RMDDataSource >> dataFrame [

	^ dataFrame
]

{ #category : #accessing }
RMDDataSource >> dataFrame: aDataFrame [

	originalDataFrame := aDataFrame forceNumericOrNil.
	dataFrame := DataFrame
		             withRows: originalDataFrame asArray
		             columnNames: originalDataFrame columnNames.
	self validateDataFrame ifFalse: [
		self flushDataFrame.
		^ self ]
]

{ #category : #defaults }
RMDDataSource >> defaultInterpolation [
	^ RMDDataInterpolation default
]

{ #category : #private }
RMDDataSource >> flushDataFrame [

	dataFrame := nil.
	lastIndex := nil.
	units := nil.
	interpolations := nil.
	cycle := nil
]

{ #category : #private }
RMDDataSource >> indexAtTime: aNumber [

	| times index t0 t1 imin imax |
	times := dataFrame column: 'time'.
	index := lastIndex ifNil: [ 1 ].
	t0 := times atIndex: index.
	t1 := times atIndex: index + 1.
	(t0 <= aNumber and: [ aNumber < t1 ]) ifTrue: [ ^ lastIndex := index ].
	(index + 2 <= times size and: [
		 t1 <= aNumber and: [ aNumber < (times atIndex: index + 1) ] ])
		ifTrue: [ ^ lastIndex := index + 1 ].
	aNumber < (times atIndex: 1) ifTrue: [ ^ lastIndex := 1 ].
	aNumber >= (times atIndex: times size) ifTrue: [
		^ lastIndex := times size - 1 ].
	aNumber < t0 ifTrue: [
		imin := 1.
		imax := index - 1 ].
	aNumber >= t1 ifTrue: [
		imin := index + 1.
		imax := times size - 1 ].
	[ imin = imax ] whileFalse: [
		index := imin + imax // 2.
		t0 := times atIndex: index.
		t1 := times atIndex: index + 1.
		(t0 <= aNumber and: [ aNumber < t1 ]) ifTrue: [
			^ lastIndex := index ].
		aNumber < t0 ifTrue: [ imax := index - 1 ].
		aNumber > t1 ifTrue: [ imin := index + 1 ] ].
	^ lastIndex := imin
]

{ #category : #interpolating }
RMDDataSource >> interpolationAt: aString [

	^ interpolations at: aString ifAbsent: [ self defaultInterpolation ]
]

{ #category : #interpolating }
RMDDataSource >> latestAtTime: aNumber with: anArrayOfDictionary [

	| t1 t2 accuracy |
	t1 := anArrayOfDictionary first at: 'time'.
	t2 := anArrayOfDictionary second at: 'time'.
	accuracy := (t2 - t1) abs * 1.0e-8.
	^ t2 - accuracy < aNumber
		  ifTrue: [ anArrayOfDictionary second ]
		  ifFalse: [ anArrayOfDictionary first ]
]

{ #category : #interpolating }
RMDDataSource >> linearAtTime: aNumber with: anArrayOfDictionary [

	| d0 d1 t0 t1 r0 r1 d |
	d0 := anArrayOfDictionary first.
	d1 := anArrayOfDictionary second.
	t0 := d0 at: 'time'.
	t1 := d1 at: 'time'.
	r0 := (aNumber - t0) asFloat / (t1 - t0).
	r0 <= 0.0 ifTrue: [ ^ d0 ].
	r0 >= 1.0 ifTrue: [ ^ d1 ].
	r1 := 1.0 - r0.
	d := Dictionary new: anArrayOfDictionary first size.
	d0 keysDo: [ :column |
		d at: column put: (d0 at: column) * r1 + ((d1 at: column) * r0) ].
	^ d
]

{ #category : #interpolating }
RMDDataSource >> nearestAtTime: aNumber with: anArrayOfDictionary [

	| d0 d1 t0 t1 |
	d0 := anArrayOfDictionary first.
	d1 := anArrayOfDictionary second.
	t0 := d0 at: 'time'.
	t1 := d1 at: 'time'.
	^ (aNumber - t0) abs < (aNumber - t1) abs
		  ifTrue: [ d0 ]
		  ifFalse: [ d1 ]
]

{ #category : #private }
RMDDataSource >> originalDataFrame [

	^ originalDataFrame
]

{ #category : #accessing }
RMDDataSource >> unitAt: aString [

	^ units at: aString ifAbsent: [ nil ]
]

{ #category : #private }
RMDDataSource >> validateDataFrame [

	| parser columnNames |
	dataFrame isNil ifTrue: [ ^ false ].
	parser := RMDGrammar current csvColumnName end.
	units := Dictionary new: dataFrame numberOfColumns.
	interpolations := Dictionary new: dataFrame numberOfColumns.
	columnNames := OrderedCollection new: dataFrame numberOfColumns.
	cycle := nil.
	dataFrame columnNames do: [ :columnName |
		| triple name unit interpolation |
		triple := parser parse: columnName.
		triple isPetit2Failure ifTrue: [ ^ false ].
		name := triple first.
		unit := triple second.
		name = 'time'
			ifTrue: [
				cycle := triple third ifNotNil: #numeric.
				interpolation := RMDDataInterpolation default ]
			ifFalse: [
				interpolation := triple third ifNil: [
					                 RMDDataInterpolation default ] ].
		dataFrame column: columnName transform: [ :v |
			(v allSatisfy: #isNumber) ifFalse: [ ^ false ].
			unit toSI: v ].
		columnNames add: name.
		units at: name put: unit.
		interpolations at: name put: interpolation ].
	(columnNames includes: 'time') ifFalse: [ ^ false ].
	dataFrame columnNames: columnNames.
	dataFrame sortBy: 'time'.
	(dataFrame column: 'time') in: [ :times |
		1 to: times size - 1 do: [ :index |
			(times atIndex: index) = (times atIndex: index + 1) ifTrue: [
				^ false ] ] ].
	cycle ifNotNil: [
		| row |
		row := dataFrame rowAt: 1.
		dataFrame
			removeRowsOfColumnElementsSatisfing: [ :t | t >= cycle ]
			onColumnNamed: 'time'.
		row at: 'time' put: cycle.
		row name: dataFrame size + 1.
		dataFrame addRow: row atPosition: dataFrame size + 1 ].
	^ true
]

{ #category : #exporting }
RMDDataSource >> writeToCsv: aFileReference [

	DataFrameCsvWriter new
		useRawFieldWriter;
		disableRowName;
		write: originalDataFrame to: aFileReference
]
