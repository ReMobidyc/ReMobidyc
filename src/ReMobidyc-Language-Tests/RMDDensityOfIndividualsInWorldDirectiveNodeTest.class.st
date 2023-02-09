Class {
	#name : #RMDDensityOfIndividualsInWorldDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDensityOfIndividualsInWorldDirectiveNodeTest >> testEvalIn [

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
		definition: (interpreter simulationModel
				 animatDefinitionAt: 'Goat'
				 ifAbsent: [ self fail ])
		taskHash: 1
		do: [ 
			self
				assert:
				('density of Goat in world' asRMDExpression evalIn: interpreter)
				equals: 9 / 36.0 ]
]

{ #category : #tests }
RMDDensityOfIndividualsInWorldDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'density of A in world'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node.
	node := parser expression end parse:
		        '(density of A in world) + (density of B in world)'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
