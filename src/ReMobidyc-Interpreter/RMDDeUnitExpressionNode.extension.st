Extension { #name : #RMDDeUnitExpressionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeUnitExpressionNode >> evalIn: aRMDInterpreter [

	^ unit fromSI: (expression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeUnitExpressionNode >> typecheckIn: aRMDInterpreter [

	| type |
	type := expression typecheckIn: aRMDInterpreter.
	^ type = (RMDType unit: unit)
		  ifTrue: [ RMDType noDimension ]
		  ifFalse: [ RMDTypeError on: expression with: type ]
]
