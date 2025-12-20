Extension { #name : 'RMDActionDefinitionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDActionDefinitionNodeTest >> testEvalIn [

	| agent script |
	agent := RMDGrammar current agentDefinition end parse: 'World with
	energy [kcal].'.
	script := RMDGrammar current actionDefinition parse: 'to metabolize is
    my delta energy'' = -basal_metabolism * 0.5 [day]
where
    basal_metabolism = 1500 [kcal/day].'.
	interpreter memory
		nextAt: 1 put: 100;
		tick.
	interpreter
		withActionContextWith: script
		subject: 1
		definition: agent
		taskHash: 1
		do: [ script evalIn: interpreter ].
	interpreter memory tick.
	self
		assert: (interpreter memory at: 1 ifAbsent: [ self fail ])
		closeTo: 100 - ('kcal' asRMDUnit toSI: 1500 * 0.5)
]
