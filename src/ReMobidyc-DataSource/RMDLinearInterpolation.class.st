Class {
	#name : #RMDLinearInterpolation,
	#superclass : #RMDDataInterpolation,
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDLinearInterpolation >> atTime: aNumber at: aString between: aDictionary and: anotherDictionary [

	| t0 t1 r0 r1 |
	t0 := aDictionary at: 'time'.
	t1 := anotherDictionary at: 'time'.
	r0 := (aNumber - t0) asFloat / (t1 - t0).
	r0 <= 0.0 ifTrue: [ ^ aDictionary at: aString ].
	r0 >= 1.0 ifTrue: [ ^ anotherDictionary at: aString ].
	r1 := 1.0 - r0.
	^ (aDictionary at: aString) * r1
	  + ((anotherDictionary at: aString) * r0)
]

{ #category : #accessing }
RMDLinearInterpolation >> name [

	^ 'linear'
]
