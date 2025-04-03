Extension { #name : 'RMDActionDefinitionNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDActionDefinitionNode >> evalIn: aRMDInterpreter [

	(guard isNil or: [ guard evalIn: aRMDInterpreter ]) ifTrue: [
		lifeDirectives do: [ :directive | directive evalIn: aRMDInterpreter ].
		attributeDefinitions do: [ :def | def evalIn: aRMDInterpreter ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDActionDefinitionNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context action: self.
	object ifNotNil: [ aRMDInterpreter context object: object ].
	lifeDirectives do: [ :def | def typecheckIn: aRMDInterpreter ].
	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	guard ifNotNil: [ guard typecheckIn: aRMDInterpreter ].
	attributeDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ]
]
