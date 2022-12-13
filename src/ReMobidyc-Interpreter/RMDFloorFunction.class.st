Class {
	#name : #RMDFloorFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDFloorFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	anArrayOfRMDExpression size = 1
		ifFalse: [ ^ (RMDTypeError on: self with: anArrayOfRMDExpression) signal ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDFloorFunction >> value: aNumber [
	^ aNumber floor asFloat
]
