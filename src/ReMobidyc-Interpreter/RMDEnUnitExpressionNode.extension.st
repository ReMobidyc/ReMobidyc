Extension { #name : #RMDEnUnitExpressionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDEnUnitExpressionNode >> evalIn: aRMDInterpreter [

	^ unit toSI: (expression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDEnUnitExpressionNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := expression typecheckIn: aRMDInterpreter.
	^ type = RMDType noDimension
		  ifTrue: [ RMDType unit: unit ]
		  ifFalse: [ RMDTypeError on: expression with: type ]
]
