Extension { #name : 'RMDGammaScaleDistributionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDGammaScaleDistributionNode >> evalIn: aRMDInterpreter [

	^ (super evalIn: aRMDInterpreter)
	  * (scaleExpression evalIn: aRMDInterpreter)
]

{ #category : '*ReMobidyc-Interpreter' }
RMDGammaScaleDistributionNode >> typecheckIn: aRMDInterpreter [

	super typecheckIn: aRMDInterpreter.
	^ [ 
	  (scaleExpression typecheckIn: aRMDInterpreter) unify:
		  RMDType noDimension ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: scaleExpression
					   type: ex type1
					   subnode: self
					   type: ex type2) ]
]
