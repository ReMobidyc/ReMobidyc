Class {
	#name : #RMDDataInterpolation,
	#superclass : #Object,
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-DataSource-Core'
}

{ #category : #accessing }
RMDDataInterpolation class >> choices [

	^ self allSubclasses reject: #isAbstract thenCollect: #current
]

{ #category : #accessing }
RMDDataInterpolation class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
RMDDataInterpolation class >> default [

	^ self latest
]

{ #category : #testing }
RMDDataInterpolation class >> isAbstract [

	^ self = RMDDataInterpolation
]

{ #category : #accessing }
RMDDataInterpolation class >> latest [

	^ RMDLatestInterpolation current
]

{ #category : #accessing }
RMDDataInterpolation class >> linear [

	^ RMDLinearInterpolation current
]

{ #category : #accessing }
RMDDataInterpolation class >> nearest [

	^ RMDNearestInterpolation current
]

{ #category : #accessing }
RMDDataInterpolation >> atTime: aNumber at: aString between: aDictionary and: anotherDictionary [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDDataInterpolation >> interpolateDataFrame: aDataFrame columnAt: columnIndex [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDDataInterpolation >> name [

	^ self subclassResponsibility
]

{ #category : #printing }
RMDDataInterpolation >> printOn: aStream [

	aStream nextPutAll: self name
]
