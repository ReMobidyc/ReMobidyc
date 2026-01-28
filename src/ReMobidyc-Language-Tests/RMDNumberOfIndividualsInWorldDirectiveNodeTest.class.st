Class {
	#name : 'RMDNumberOfIndividualsInWorldDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDNumberOfIndividualsInWorldDirectiveNodeTest >> testEvalIn [

	interpreter
		load: (parser animatDefinition end parse: 'Goat is Animat with
	body [kcal]
	age [day].');
		load: (parser simulationDefinition end parse: 'Simulation with
	during 10[day] by 0.5[day]
	3 x 3 of  1[m] Patch
	2 Goat with
		x = 0.5[m]
		y = 0.5[m]
	3 Goat with
		x = 1.5[m]
		y = 0.5[m]
	4 Goat with
		x = 2.5[m]
		y = 2.5[m].');
		setupSimulation.
	"10 14 => 0.5@0.5, 18 22 26 => 1.5@0.5, 30 34 38 42 => 2.5@2.5"
	self assert: (interpreter memory animat: 'Goat' includes: 10).
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 10
		definition: (interpreter simulationModel
				 animatDefinitionAt: 'Goat'
				 ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('number of Goat in world' asRMDExpression evalIn: interpreter)
				equals: 9 ].
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 18
		definition: (interpreter simulationModel
				 animatDefinitionAt: 'Goat'
				 ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('number of Goat in world' asRMDExpression evalIn: interpreter)
				equals: 9 ].
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: 34
		definition: (interpreter simulationModel
				 animatDefinitionAt: 'Goat'
				 ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('number of Animat in world' asRMDExpression evalIn: interpreter)
				equals: 9 ]
]

{ #category : 'tests' }
RMDNumberOfIndividualsInWorldDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'number of A in world'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(number of A in world) + (number of B in world)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
