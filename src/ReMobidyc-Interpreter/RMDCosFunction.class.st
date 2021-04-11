Class {
	#name : #RMDCosFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDCosFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
	^ anArrayOfRMDExpression size = 1
		ifTrue: [ anArrayOfRMDExpression first
				inferType;
				unifyType: RMDUnit rad.
			RMDUnit noDimension ]
]

{ #category : #accessing }
RMDCosFunction >> value: aNumber [
	^ aNumber cos
]
