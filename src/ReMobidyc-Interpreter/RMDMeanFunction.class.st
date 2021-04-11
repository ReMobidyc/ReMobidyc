Class {
	#name : #RMDMeanFunction,
	#superclass : #RMDFunction,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'type checking' }
RMDMeanFunction >> inferTypeWithArguments: anArrayOfRMDExpression [
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
RMDMeanFunction >> value: aNumber [
	^ aNumber
]

{ #category : #accessing }
RMDMeanFunction >> value: aNumber1 value: aNumber2 [
	^ (aNumber1 + aNumber2) / 2.0
]

{ #category : #accessing }
RMDMeanFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ (aNumber1 + aNumber2 + aNumber3) / 3.0
]

{ #category : #accessing }
RMDMeanFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ (aNumber1 + aNumber2 + aNumber3 + aNumber4) / 4.0
]

{ #category : #accessing }
RMDMeanFunction >> valueWithArguments: anArrayOfNumber [
	anArrayOfNumber ifEmpty: [ ^ self numArgsError ].
	^ anArrayOfNumber sum / anArrayOfNumber size
]
