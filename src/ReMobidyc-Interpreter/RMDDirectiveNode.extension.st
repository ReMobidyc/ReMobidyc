Extension { #name : #RMDDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDDirectiveNode >> typecheck: aRMDAttributeVariableNode with: aRMDType in: aRMDInterpreter [

	^ [ 
	  (aRMDAttributeVariableNode typecheckIn: aRMDInterpreter) unify:
		  aRMDType ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ex resignalAs: (RMDTypeError
					   on: self
					   subnode: aRMDAttributeVariableNode
					   type: ex type1
					   subnode: self
					   type: ex type2) ]
]
