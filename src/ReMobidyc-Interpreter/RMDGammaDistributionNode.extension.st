Extension { #name : #RMDGammaDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> evalIn: aRMDInterpreter [

	^ self
		  gamma: (shapeExpression evalIn: aRMDInterpreter)
		  in: aRMDInterpreter
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaDistributionNode >> typecheckIn: aRMDInterpreter [

	^ [ 
	  (shapeExpression typecheckIn: aRMDInterpreter) unify:
		  RMDType noDimension ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: shapeExpression
					   type: ex type1
					   subnode: self
					   type: ex type2) ]
]
