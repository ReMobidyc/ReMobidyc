Class {
	#name : #RMDAbsFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDAbsFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
	^ anArrayOfRMDExpression size = 1
		ifTrue: [ anArrayOfRMDExpression first inferType ]
]

{ #category : #accessing }
RMDAbsFunction >> value: aNumber [
	^ aNumber abs
]
