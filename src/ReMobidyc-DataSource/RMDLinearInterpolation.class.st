Class {
	#name : #RMDLinearInterpolation,
	#superclass : #RMDDataInterpolation,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDLinearInterpolation >> atTime: aNumber at: aString between: aDictionary and: anotherDictionary [

	| t0 t1 v0 v1 a b |
	t0 := aDictionary at: 'time'.
	t1 := anotherDictionary at: 'time'.
	v0 := (aDictionary at: aString) asFloat.
	v1 := (anotherDictionary at: aString) asFloat.
	a := v1 - v0 / (t1 - t0).
	b := v0.
	^ a * (aNumber - t0) + b
]

{ #category : #private }
RMDLinearInterpolation >> findFirstNonNilRowIndex: aDataFrame columnAt: columnIndex startingAt: anInteger [

	anInteger to: aDataFrame numberOfRows do: [ :rowIndex |
		(aDataFrame at: rowIndex at: columnIndex) ifNotNil: [ ^ rowIndex ] ].
	^ nil
]

{ #category : #accessing }
RMDLinearInterpolation >> interpolateDataFrame: aDataFrame columnAt: columnIndex [

	| index0 index1 t0 t1 v0 v1 a b |
	index0 := (self
		           findFirstNonNilRowIndex: aDataFrame
		           columnAt: columnIndex
		           startingAt: 1) ifNil: [ ^ self ].
	index1 := (self
		           findFirstNonNilRowIndex: aDataFrame
		           columnAt: columnIndex
		           startingAt: index0 + 1) ifNil: [ ^ self ].
	t0 := (aDataFrame at: index0 at: 1) asFloat.
	v0 := (aDataFrame at: index0 at: columnIndex) asFloat.
	t1 := (aDataFrame at: index1 at: 1) asFloat.
	v1 := (aDataFrame at: index1 at: columnIndex) asFloat.
	a := v1 - v0 / (t1 - t0).
	b := v0.
	1 to: index0 - 1 do: [ :index |
		| t |
		t := (aDataFrame at: index at: 1) asFloat.
		aDataFrame at: index at: columnIndex put: a * (t - t0) + b ].
	index0 + 1 to: index1 - 1 do: [ :index |
		| t |
		t := (aDataFrame at: index at: 1) asFloat.
		aDataFrame at: index at: columnIndex put: a * (t - t0) + b ].
	[
	index0 := index1.
	index1 := self
		          findFirstNonNilRowIndex: aDataFrame
		          columnAt: columnIndex
		          startingAt: index0 + 1.
	index1 notNil ] whileTrue: [
		t0 := t1.
		v0 := v1.
		t1 := (aDataFrame at: index1 at: 1) asFloat.
		v1 := (aDataFrame at: index1 at: columnIndex) asFloat.
		a := v1 - v0 / (t1 - t0).
		b := v0.
		index0 + 1 to: index1 - 1 do: [ :index |
			| t |
			t := (aDataFrame at: index at: 1) asFloat.
			aDataFrame at: index at: columnIndex put: a * (t - t0) + b ] ].
	index0 + 1 to: aDataFrame numberOfRows do: [ :index |
		| t |
		t := (aDataFrame at: index at: 1) asFloat.
		aDataFrame at: index at: columnIndex put: a * (t - t0) + b ]
]

{ #category : #accessing }
RMDLinearInterpolation >> name [

	^ 'linear'
]
