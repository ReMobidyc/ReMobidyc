Class {
	#name : #RMDMinFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDMinFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	| type |
	type := RMDType any.
	anArrayOfRMDExpression
		do:
			[ :expression | type := type unify: (expression typecheckIn: aRMDInterpreter) ].
	^ type
]

{ #category : #evaluating }
RMDMinFunction >> value: aNumber1 [
	^ aNumber1
]

{ #category : #evaluating }
RMDMinFunction >> value: aNumber1 value: aNumber2 [
	^ aNumber1 min: aNumber2
]

{ #category : #evaluating }
RMDMinFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ (aNumber1 min: aNumber2) min: aNumber3
]

{ #category : #evaluating }
RMDMinFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ ((aNumber1 min: aNumber2) min: aNumber3) min: aNumber4
]

{ #category : #evaluating }
RMDMinFunction >> valueWithArguments: anArrayOfNumber [
	anArrayOfNumber ifEmpty: [ ^ self numArgsError ].
	^ anArrayOfNumber
		inject: anArrayOfNumber first
		into: [ :min :each | min min: each ]
]
