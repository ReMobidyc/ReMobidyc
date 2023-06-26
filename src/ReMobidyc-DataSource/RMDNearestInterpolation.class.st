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
