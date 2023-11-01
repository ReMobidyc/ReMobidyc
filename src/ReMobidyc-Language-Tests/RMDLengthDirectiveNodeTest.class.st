Class {
	#name : #RMDLengthDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLengthDirectiveNodeTest >> testEvalIn [

	interpreter
		load: (parser simulationDefinition end parse: 'Simulation with
	during 10[day] by 0.5[day]
	3 x 3 of  2[m] Patch.');
		setupSimulation.
	self
		assert: ('length of here' asRMDExpression evalIn: interpreter)
		closeTo: 2.0
]

{ #category : #tests }
RMDLengthDirectiveNodeTest >> testPrintOn [

	| node copy |
	node := parser expression end parse: 'length of here'.
	copy := parser expression end parse: node printString.
	self assert: copy equals: node
]
