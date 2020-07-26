Extension { #name : #RMDActionDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDActionDefinitionNode >> evalIn: aRMDInterpreter [
	aRMDInterpreter context action: self.
	(guard isNil or: [ guard evalIn: aRMDInterpreter ])
		ifTrue: [ propertyDefinitions do: [ :def | def evalIn: aRMDInterpreter ] ]
]
