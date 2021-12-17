Extension { #name : #RMDActionDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionDefinitionNode >> evalIn: aRMDInterpreter [

	aRMDInterpreter context action: self.
	(guard isNil or: [ guard evalIn: aRMDInterpreter ]) ifTrue: [ 
		lifeDirectives do: [ :directive | directive evalIn: aRMDInterpreter ].
		propertyDefinitions do: [ :def | def evalIn: aRMDInterpreter ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionDefinitionNode >> typecheckIn: aRMDInterpreter [
	utilityDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ].
	guard ifNotNil: [ guard typecheckIn: aRMDInterpreter ].
	propertyDefinitions do: [ :def | def typecheckIn: aRMDInterpreter ]
]
