Extension { #name : #RMDUniformDistributionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> evalIn: aRMDInterpreter [

	| to from |
	to := toExpression evalIn: aRMDInterpreter.
	from := fromExpression evalIn: aRMDInterpreter.
	^ to - from * aRMDInterpreter random + from
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDUniformDistributionNode >> typecheckIn: aRMDInterpreter [
	^ [ (fromExpression typecheckIn: aRMDInterpreter)
		unify: (toExpression typecheckIn: aRMDInterpreter) ]
		on: RMDTypeUnificationError
		do: [ :ex | ex resignalAs: (RMDTypeError on: self with: ex type1) ]
]
