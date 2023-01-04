Extension { #name : #RMDKillDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDKillDirectiveNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter terminate: 'object'
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDKillDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context objectDefinition
		ifNil: [ ^ RMDUndefinedObjectError signal: self ]
		ifNotNil: [ :object | 
			object isAnimatDefinitionNode ifFalse: [ 
				^ RMDUndefinedObjectError signal: self ] ]
]
