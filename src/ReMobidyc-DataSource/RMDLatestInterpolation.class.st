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

{ #category : #accessing }
RMDLatestInterpolation >> name [

	^ 'latest'
]
