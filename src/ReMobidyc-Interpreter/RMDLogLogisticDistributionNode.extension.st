Extension { #name : 'RMDLogLogisticDistributionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDLogLogisticDistributionNode >> evalIn: aRMDInterpreter [

	| p |
	p := aRMDInterpreter random.
	^ (scaleExpression evalIn: aRMDInterpreter)
	  *
	  (p / (1 - p)
	   ** (shapeExpression evalIn: aRMDInterpreter) reciprocal)
]

{ #category : '*ReMobidyc-Interpreter' }
RMDLogLogisticDistributionNode >> typecheckIn: aRMDInterpreter [

	[
	(shapeExpression typecheckIn: aRMDInterpreter) unify:
		RMDType noDimension ]
		on: RMDTypeUnificationError
		do: [ :ex |
			ex resignalAs: (RMDTypeError
					 on: self
					 subnode: shapeExpression
					 type: ex type1
					 subnode: self
					 type: ex type2) ].
	^ type := [ scaleExpression typecheckIn: aRMDInterpreter ]
		          on: RMDTypeUnificationError
		          do: [ :ex |
			          ex resignalAs: (RMDTypeError
					           on: self
					           subnode: scaleExpression
					           type: ex type1
					           subnode: self
					           type: ex type2) ]
]
