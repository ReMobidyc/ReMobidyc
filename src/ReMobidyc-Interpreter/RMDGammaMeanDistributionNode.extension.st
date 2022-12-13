Extension { #name : #RMDGammaMeanDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaMeanDistributionNode >> evalIn: aRMDInterpreter [

	| shape mean |
	shape := shapeExpression evalIn: aRMDInterpreter.
	mean := meanExpression evalIn: aRMDInterpreter.
	^ (self gamma: shape / mean in: aRMDInterpreter) * mean
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaMeanDistributionNode >> typecheckIn: aRMDInterpreter [

	super typecheckIn: aRMDInterpreter.
	^ [ meanExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
