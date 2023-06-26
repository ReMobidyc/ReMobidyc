Class {
	#name : #RMDAbstractDataSource,
	#superclass : #Object,
	#instVars : [
		'dataFrame',
		'units',
		'lastIndex'
	],
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #testing }
RMDAbstractDataSource class >> isAbstract [

	^ self = RMDAbstractDataSource
]

{ #category : #accessing }
RMDAbstractDataSource >> atTime: aNumber [

	^ self atTime: aNumber with: (self basicAtTime: aNumber)
]

{ #category : #accessing }
RMDAbstractDataSource >> atTime: aNumber at: aString [

	^ (self atTime: aNumber) at: aString
]

{ #category : #private }
RMDAbstractDataSource >> atTime: aNumber with: anArrayOfDictionary [

	^ self subclassResponsibility
]

{ #category : #private }
RMDAbstractDataSource >> basicAtTime: aNumber [

	| index |
	index := self indexAtTime: aNumber.
	^ {
		  (dataFrame rowAt: index) asDictionary.
		  (dataFrame rowAt: index + 1) asDictionary }
]

{ #category : #accessing }
RMDAbstractDataSource >> dataFrame: aDataFrame [

	dataFrame := aDataFrame.
	self validateDataFrame ifFalse: [
		self flushDataFrame.
		^ self ]
]

{ #category : #private }
RMDAbstractDataSource >> flushDataFrame [

	dataFrame := nil.
	lastIndex := nil
]

{ #category : #private }
RMDAbstractDataSource >> indexAtTime: aNumber [

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

{ #category : #accessing }
RMDAbstractDataSource >> readFromCsv: aFileReference [

	self dataFrame: (DataFrame readFromCsv: aFileReference)
]

{ #category : #accessing }
RMDAbstractDataSource >> unitAt: aString [

	^ units at: aString ifAbsent: [ nil ]
]

{ #category : #private }
RMDAbstractDataSource >> validateDataFrame [

	| parser columnNames |
	dataFrame isNil ifTrue: [ ^ false ].
	parser := RMDGrammar new csvColumnName end.
	units := Dictionary new: dataFrame numberOfColumns.
	columnNames := OrderedCollection new: dataFrame numberOfColumns.
	dataFrame columnNames do: [ :columnName |
		| pair name unit |
		pair := parser parse: columnName.
		pair isPetit2Failure ifTrue: [ ^ false ].
		name := pair first.
		unit := pair second.
		dataFrame column: columnName transform: [ :v | unit toSI: v ].
		columnNames add: name.
		units at: name put: unit ].
	(columnNames includes: 'time') ifFalse: [ ^ false ].
	dataFrame columnNames: columnNames.
	dataFrame sortBy: 'time'.
	(dataFrame column: 'time') in: [ :times |
		1 to: times size - 1 do: [ :index |
			(times atIndex: index) = (times atIndex: index + 1) ifTrue: [
				^ false ] ] ].
	^ true
]
