Extension { #name : #RMDWorldInitializerNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDWorldInitializerNodeTest >> testEvalIn [
	| worldDef worldInitializer |
	worldDef := parser worldDefinition
		parse:
			'World with
	temperature [C]
	humidity [].'.
	worldInitializer := parser worldInitializer
		parse:
			'World with
			temperature = -10 [C]
			humidity = 0.4 []'.
	interpreter memory allocateIndividualOf: worldDef.
	interpreter
		setContext: (RMDInitializerContext subject: 1 species: worldDef).
	worldInitializer evalIn: interpreter.
	interpreter tick.
	self
		assert: (interpreter readVariable: 'temperature' agent: nil ifAbsent: [ nil ])
		closeTo: (RMDUnit C toSI: -10).
	self
		assert: (interpreter readVariable: 'humidity' agent: nil ifAbsent: [ nil ])
		closeTo: 0.4
]
