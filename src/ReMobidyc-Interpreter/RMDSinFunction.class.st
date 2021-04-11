Class {
	#name : #RMDSinFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDSinFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
	^ anArrayOfRMDExpression size = 1
		ifTrue: [ anArrayOfRMDExpression first
				inferType;
				unifyType: RMDUnit rad.
			RMDUnit noDimension ]
]

{ #category : #accessing }
RMDSinFunction >> value: aNumber [
	^ aNumber sin
]
