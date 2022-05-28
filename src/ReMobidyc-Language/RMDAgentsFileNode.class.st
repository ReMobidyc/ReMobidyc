Class {
	#name : #RMDAgentsFileNode,
	#superclass : #RMDModelFileNode,
	#instVars : [
		'agents'
	],
	#category : #'ReMobidyc-Language-File'
}

{ #category : #'instance creation' }
RMDAgentsFileNode class >> agents: anArrayOfRMDSpeciesDefinitionNode [

	^ self new
		  agents: anArrayOfRMDSpeciesDefinitionNode;
		  yourself
]

{ #category : #accessing }
RMDAgentsFileNode >> agents [

	^ agents
]

{ #category : #accessing }
RMDAgentsFileNode >> agents: anArrayOfRMDSpeciesDefinitionNode [

	agents := anArrayOfRMDSpeciesDefinitionNode
]

{ #category : #enumerating }
RMDAgentsFileNode >> contentsDo: aBlock [

	agents do: aBlock
]

{ #category : #testing }
RMDAgentsFileNode >> isAgentsFileNode [
	^ true
]
