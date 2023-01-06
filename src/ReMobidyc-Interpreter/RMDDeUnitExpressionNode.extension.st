Extension { #name : #RMDDeUnitExpressionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeUnitExpressionNode >> evalIn: aRMDInterpreter [

	^ (unit fromSI: (expression evalIn: aRMDInterpreter)) ifNanOrInfinite: [ 
		  RMDNotComputableError on: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDDeUnitExpressionNode >> typecheckIn: aRMDInterpreter [

	[ 
	(expression typecheckIn: aRMDInterpreter) unify: (RMDType unit: unit) ]
		on: RMDTypeUnificationError
		do: [ :ex | 
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: expression
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ RMDType noDimension
]
