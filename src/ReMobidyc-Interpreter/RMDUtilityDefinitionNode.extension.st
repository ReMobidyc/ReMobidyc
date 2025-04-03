Extension { #name : 'RMDUtilityDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDUtilityDefinitionNode >> evalIn: aRMDInterpreter [

	^ [ 
	  aRMDInterpreter
		  write: (definitionBody evalIn: aRMDInterpreter)
		  toUtility: variable identifier ]
		  on: RMDSemanticError
		  do: [ :ex | ex signalWithScope: self ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDUtilityDefinitionNode >> typecheckIn: aRMDInterpreter [

	^ [
	  aRMDInterpreter
		  typeUtilityVariable: variable identifier
		  as: (definitionBody typecheckIn: aRMDInterpreter) ]
		  on: RMDSemanticError
		  do: [ :ex | ex signalWithScope: self ]
]
