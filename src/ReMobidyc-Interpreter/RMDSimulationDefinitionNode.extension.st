Extension { #name : #RMDSimulationDefinitionNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDSimulationDefinitionNode >> evalIn: aRMDInterpreter [
	timeInitializer ifNotNil: [ :def | def evalIn: aRMDInterpreter ].
	cellInitializer ifNotNil: [ :def | def evalIn: aRMDInterpreter ].
	animatInitializers
		ifNotNil: [ :defs | defs do: [ :def | def evalIn: aRMDInterpreter ] ]
]
