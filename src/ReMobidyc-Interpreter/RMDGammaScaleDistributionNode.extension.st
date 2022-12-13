Extension { #name : #RMDGammaScaleDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaScaleDistributionNode >> evalIn: aRMDInterpreter [

	^ (super evalIn: aRMDInterpreter)
	  / (scaleExpression evalIn: aRMDInterpreter)
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDGammaScaleDistributionNode >> typecheckIn: aRMDInterpreter [

	super typecheckIn: aRMDInterpreter.
	^ [ shapeExpression typecheckIn: aRMDInterpreter ]
		  on: RMDTypeUnificationError
		  do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
