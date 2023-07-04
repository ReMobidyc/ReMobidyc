Class {
	#name : #RMDLatestInterpolation,
	#superclass : #RMDDataInterpolation,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDLatestInterpolation >> atTime: aNumber at: aString between: aDictionary and: anotherDictionary [

	| t1 t2 accuracy |
	t1 := aDictionary at: 'time'.
	t2 := anotherDictionary at: 'time'.
	accuracy := (t2 - t1) abs * 1.0e-8.
	^ (t2 - accuracy < aNumber
		   ifTrue: [ anotherDictionary ]
		   ifFalse: [ aDictionary ]) at: aString
]

{ #category : #private }
RMDLatestInterpolation >> findFirstNonNil: aDataFrame columnAt: columnIndex [

	1 to: aDataFrame numberOfRows do: [ :rowIndex |
		(aDataFrame at: rowIndex at: columnIndex) ifNotNil: [ :value |
			^ value ] ].
	^ nil
]

{ #category : #accessing }
RMDLatestInterpolation >> interpolateDataFrame: aDataFrame columnAt: columnIndex [

	(self findFirstNonNil: aDataFrame columnAt: columnIndex) ifNotNil: [
		:firstNonNil |
		| lastValue |
		lastValue := firstNonNil.
		1 to: aDataFrame numberOfRows do: [ :rowIndex |
			aDataFrame at: rowIndex at: columnIndex transform: [ :value |
				value ifNil: [ lastValue ] ifNotNil: [ lastValue := value ] ] ] ]
]

{ #category : #accessing }
RMDLatestInterpolation >> name [

	^ 'latest'
]
