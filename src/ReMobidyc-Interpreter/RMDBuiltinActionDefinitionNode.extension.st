Extension { #name : #RMDBuiltinActionDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDBuiltinActionDefinitionNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter actionDirective: identifier object: object
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDBuiltinActionDefinitionNode >> typecheckIn: aRMDInterpreter [
]
