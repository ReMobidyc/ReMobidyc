Class {
	#name : 'RMDDensityOfIndividualsInPatchDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDDensityOfIndividualsInPatchDirectiveNodeTest >> testEvalIn [

	interpreter
		load: (parser animatDefinition end parse: 'Goat is Animat with
	body [kcal]
	age [day].');
		load: (parser simulationDefinition end parse: 'Simulation with
	during 10[day] by 0.5[day]
	3 x 3 of  2[m] Patch
	2 Goat with
		x = 1[m]
		y = 1[m]
	3 Goat with
		x = 3[m]
		y = 3[m]
	4 Goat with
		x = 5[m]
		y = 5[m].');
		setupSimulation.
	self assert: (interpreter memory animat: 'Goat' includes: 10).
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 10
		definition:
		(interpreter simulationModel animatDefinitionAt: 'Goat' ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('density of Goat here' asRMDExpression evalIn: interpreter)
				equals: 2 / 4.0 ].
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 18
		definition:
		(interpreter simulationModel animatDefinitionAt: 'Goat' ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('density of Goat here' asRMDExpression evalIn: interpreter)
				equals: 3 / 4.0 ].
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 34
		definition:
		(interpreter simulationModel animatDefinitionAt: 'Goat' ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('density of Goat here' asRMDExpression evalIn: interpreter)
				equals: 4 / 4.0 ]
]

{ #category : 'tests' }
RMDDensityOfIndividualsInPatchDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'density of A here'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(density of A here) + (density of B here)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
