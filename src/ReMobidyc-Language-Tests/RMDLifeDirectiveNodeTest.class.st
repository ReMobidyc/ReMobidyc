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
		load: (RMDGrammar current patchDefinition parse: 'Patch.');
		load:
			(aDef := RMDGrammar current animatDefinition parse: 'A is Animat.');
		load:
			(bDef := RMDGrammar current animatDefinition parse: 'B is Animat.').
	interpreter load: (RMDSimulationDefinitionNode
			 timeDefinition:
			 (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
			 worldInitializer: RMDWorldInitializerNode empty
			 patchInitializer:
			 (RMDGrammar current patchInitializer parse: '1x1 of 1[m] Patch')
			 animatInitializers: {
					 (RMDGrammar current animatInitializer parse: '1 A').
					 (RMDGrammar current animatInitializer parse: '1 B') }).
	interpreter setupSimulation
]
