Class {
	#name : 'RMDSimulationFileNode',
	#superclass : 'RMDModelFileNode',
	#instVars : [
		'simulationDefinition'
	],
	#category : 'ReMobidyc-Language-File',
	#package : 'ReMobidyc-Language',
	#tag : 'File'
}

{ #category : 'instance creation' }
RMDSimulationFileNode class >> simulationDefinition: aRMDSimulationDefinitionNode [

	^ self new
		  simulationDefinition: aRMDSimulationDefinitionNode;
		  yourself
]

{ #category : 'enumerating' }
RMDSimulationFileNode >> contentsDo: aBlock [

	simulationDefinition value: aBlock
]

{ #category : 'testing' }
RMDSimulationFileNode >> isSimulationFileNode [

	^ true
]

{ #category : 'accessing' }
RMDSimulationFileNode >> simulationDefinition [

	^ simulationDefinition
]

{ #category : 'accessing' }
RMDSimulationFileNode >> simulationDefinition: aRMDSimulationDefinitionNode [

	simulationDefinition := aRMDSimulationDefinitionNode
]
