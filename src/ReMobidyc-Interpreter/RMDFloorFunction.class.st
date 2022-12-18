Class {
	#name : #RMDFloorFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDFloorFunction >> expectedNumArgs [

	^ 1
]

{ #category : #'type checking' }
RMDFloorFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [

	anArrayOfRMDExpression size = 1 ifFalse: [ 
		^ RMDNumArgsError
			  signal: self
			  actual: anArrayOfRMDExpression size
			  expected: 1 ].
	^ anArrayOfRMDExpression first typecheckIn: aRMDInterpreter
]

{ #category : #accessing }
RMDFloorFunction >> value: aNumber [
	^ aNumber floor asFloat
]
