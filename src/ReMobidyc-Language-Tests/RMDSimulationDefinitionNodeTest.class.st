Class {
	#name : 'RMDSimulationDefinitionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDSimulationDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser simulationDefinition end parse: 'Simulation with
	during 1 [year] step by 1[day]
	World with
		p = -1
		q = r
		where
			r = -2
	1x1 of 1[m] Patch with
		v = 0
	10 A with
		x = 1
	20 B with
		y = 2.'.
	copy := parser simulationDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser simulationDefinition end parse: 'Simulation with
	during 1 [year] step by 1[day]
	World with
		p = -1
		q = -2
	1x1 of 1[m] Patch with
		v = 0
	10 A with
		x = 1
	20 B with
		y = 2.'.
	copy := parser simulationDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser simulationDefinition end parse: 'Simulation with
	during 1 [year] step by 1[day]
	1x1 of 1[m] Patch
	10 A with
		x = 1
	20 B with
		y = 2.'.
	copy := parser simulationDefinition end parse: node printString.
	self assert: copy equals: node
]
