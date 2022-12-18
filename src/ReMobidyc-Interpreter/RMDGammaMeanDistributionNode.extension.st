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
	^ [ 
	  (meanExpression typecheckIn: aRMDInterpreter) unify:
		  RMDType noDimension ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: meanExpression
					   type: ex type1
					   subnode: self
					   type: ex type2) ]
]
