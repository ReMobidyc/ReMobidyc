Class {
	#name : #RMDSumFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter-Libraries'
}

{ #category : #accessing }
RMDSumFunction >> expectedNumArgs [

	^ nil
]

{ #category : #'type checking' }
RMDSumFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	| type |
	type := RMDType any.
	anArrayOfRMDExpression do: [ :expression | 
		type := type unify: (expression typecheckIn: aRMDInterpreter) ].
	^ type
]

{ #category : #accessing }
RMDSumFunction >> value: aNumber [
	^ aNumber
]

{ #category : #accessing }
RMDSumFunction >> value: aNumber1 value: aNumber2 [
	^ aNumber1 + aNumber2
]

{ #category : #accessing }
RMDSumFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ aNumber1 + aNumber2 + aNumber3
]

{ #category : #accessing }
RMDSumFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ aNumber1 + aNumber2 + aNumber3 + aNumber4
]

{ #category : #evaluating }
RMDSumFunction >> valueWithArguments: anArrayOfNumber [
	anArrayOfNumber ifEmpty: [ ^ self numArgsError ].
	^ anArrayOfNumber sum
]
