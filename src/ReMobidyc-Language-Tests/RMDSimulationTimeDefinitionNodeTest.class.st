Class {
	#name : 'RMDSimulationTimeDefinitionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDSimulationTimeDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser simulationTimeDefinition end parse:
		        'during 1 [year] step by 1[day]'.
	copy := parser simulationTimeDefinition end parse: node printString.
	self assert: copy equals: node
]
