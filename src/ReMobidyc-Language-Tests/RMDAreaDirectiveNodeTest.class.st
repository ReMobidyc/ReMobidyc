Class {
	#name : 'RMDAreaDirectiveNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDAreaDirectiveNodeTest >> testEvalIn [

	interpreter
		load: (parser simulationDefinition end parse: 'Simulation with
	during 10[day] by 0.5[day]
	3 x 3 of  2[m] Patch.');
		setupSimulation.
	self
		assert: ('area of here' asRMDExpression evalIn: interpreter)
		closeTo: 4.0
]

{ #category : 'tests' }
RMDAreaDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'area of here'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
