Extension { #name : 'RMDWorldInitializerNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDWorldInitializerNodeTest >> testEvalIn [

	| worldDef worldInitializer count |
	worldDef := parser worldDefinition end parse: 'World with
	temperature [DegreeC]
	humidity [].'.
	worldInitializer := parser worldInitializer parse: 'World with
			temperature = -10 [DegreeC]
			humidity = 0.4 []'.
	interpreter simulationModel worldDefinition: worldDef.
	worldInitializer evalIn: interpreter.
	count := 0.
	interpreter memory tick.
	interpreter individualsOf: worldDef do: [ :world | 
		interpreter
			withActionContextWith: RMDActionDefinitionNode template
			subject: world
			definition: worldDef
			taskHash: 1
			do: [ 
				self
					assert: (interpreter my: 'temperature')
					closeTo: (RMDUnit celsius toSI: -10).
				self assert: (interpreter my: 'humidity') closeTo: 0.4.
				self assert: interpreter time closeTo: 0.0.
				count := count + 1 ] ].
	self assert: count equals: 1
]
