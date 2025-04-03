Class {
	#name : 'RMDMaxFunction',
	#superclass : 'RMDFunction',
	#category : 'ReMobidyc-Interpreter-Libraries',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Libraries'
}

{ #category : 'accessing' }
RMDMaxFunction >> expectedNumArgs [

	^ nil
]

{ #category : 'type checking' }
RMDMaxFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [

	| type |
	type := RMDType any.
	anArrayOfRMDExpression do: [ :expression | 
		type := type unify: (expression typecheckIn: aRMDInterpreter) ].
	^ type
]

{ #category : 'accessing' }
RMDMaxFunction >> value: aNumber [
	^ aNumber
]

{ #category : 'accessing' }
RMDMaxFunction >> value: aNumber1 value: aNumber2 [
	^ aNumber1 max: aNumber2
]

{ #category : 'accessing' }
RMDMaxFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ (aNumber1 max: aNumber2) max: aNumber3
]

{ #category : 'accessing' }
RMDMaxFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ ((aNumber1 max: aNumber2) max: aNumber3) max: aNumber4
]

{ #category : 'accessing' }
RMDMaxFunction >> valueWithArguments: anArrayOfNumber [
	anArrayOfNumber ifEmpty: [ ^ self numArgsError ].
	^ anArrayOfNumber
		inject: anArrayOfNumber first
		into: [ :max :each | max max: each ]
]
