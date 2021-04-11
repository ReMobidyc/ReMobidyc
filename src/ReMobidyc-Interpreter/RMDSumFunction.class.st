Class {
	#name : #RMDSumFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDSumFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
	| type |
	type := nil.
	anArrayOfRMDExpression
		do: [ :expression | 
			type := expression
				inferType;
				unifyType: type ].
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
