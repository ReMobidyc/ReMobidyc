Class {
	#name : #RMDNearestInterpolation,
	#superclass : #RMDDataInterpolation,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDNearestInterpolation >> atTime: aNumber at: aString between: aDictionary and: anotherDictionary [

	| t0 t1 |
	t0 := aDictionary at: 'time'.
	t1 := anotherDictionary at: 'time'.
	^ ((aNumber - t0) abs < (aNumber - t1) abs
		   ifTrue: [ aDictionary ]
		   ifFalse: [ anotherDictionary ]) at: aString
]

{ #category : #private }
RMDNearestInterpolation >> findFirstNonNilRowIndex: aDataFrame columnAt: columnIndex startingAt: anInteger [

	anInteger to: aDataFrame numberOfRows do: [ :rowIndex |
		(aDataFrame at: rowIndex at: columnIndex) ifNotNil: [ ^ rowIndex ] ].
	^ nil
]

{ #category : #accessing }
RMDNearestInterpolation >> interpolateDataFrame: aDataFrame columnAt: columnIndex [

	| index0 index1 t0 t1 v0 v1 |
	index1 := (self
		           findFirstNonNilRowIndex: aDataFrame
		           columnAt: columnIndex
		           startingAt: 1) ifNil: [ ^ self ].
	t1 := (aDataFrame at: index1 at: 1) asFloat.
	v1 := (aDataFrame at: index1 at: columnIndex) asFloat.
	1 to: index1 - 1 do: [ :index |
	aDataFrame at: index at: columnIndex put: v1 ].
	[
	index0 := index1.
	index1 := self
		          findFirstNonNilRowIndex: aDataFrame
		          columnAt: columnIndex
		          startingAt: index0 + 1.
	index1 notNil ] whileTrue: [
		v0 := v1.
		t0 := t1.
		t1 := (aDataFrame at: index1 at: 1) asFloat.
		v1 := (aDataFrame at: index1 at: columnIndex) asFloat.
		index0 + 1 to: index1 - 1 do: [ :index |
			| t |
			t := (aDataFrame at: index at: 1) asFloat.
			aDataFrame
				at: index
				at: columnIndex
				put: ((t - t0) abs <= (t1 - t) abs
						 ifTrue: [ v0 ]
						 ifFalse: [ v1 ]) ] ].
	index0 + 1 to: aDataFrame numberOfRows do: [ :index |
	aDataFrame at: index at: columnIndex put: v1 ]
]

{ #category : #accessing }
RMDNearestInterpolation >> name [

	^ 'nearest'
]
