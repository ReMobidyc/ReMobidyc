Class {
	#name : #RMDLifeDirectiveNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#instVars : [
		'bDef',
		'aDef'
	],
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #testing }
RMDLifeDirectiveNodeTest class >> isAbstract [ 
	^ self == RMDLifeDirectiveNodeTest
]

{ #category : #initialization }
RMDLifeDirectiveNodeTest >> setUpInterpreter [

	super setUpInterpreter.
	interpreter simulationModel
		load: (RMDGrammar new cellDefinition parse: 'Cell.');
		load:
			(aDef := RMDGrammar new animatDefinition parse: 'A is Animat.');
		load:
			(bDef := RMDGrammar new animatDefinition parse: 'B is Animat.').
	interpreter load: (RMDSimulationDefinitionNode
			 timeDefinition:
			 (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
			 worldInitializer: RMDWorldInitializerNode empty
			 cellInitializer:
			 (RMDGrammar new cellInitializer parse: '1x1 of 1[m] Cell')
			 animatInitializers: { 
					 (RMDGrammar new animatInitializer parse: '1 A').
					 (RMDGrammar new animatInitializer parse: '1 B') }).
	interpreter setupSimulation
]
