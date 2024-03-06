Extension { #name : #RMDEnUnitExpressionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDEnUnitExpressionNode >> evalIn: aRMDInterpreter [

	^ (unit toSI: (expression evalIn: aRMDInterpreter)) ifNanOrInfinite: [ 
		  RMDNotComputableError on: self ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDEnUnitExpressionNode >> typecheckIn: aRMDInterpreter [

	[
	(expression typecheckIn: aRMDInterpreter) unify: RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex |
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: expression
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ type := RMDType unit: unit
]
