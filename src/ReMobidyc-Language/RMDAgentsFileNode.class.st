Class {
	#name : #RMDAgentsFileNode,
	#superclass : #RMDModelFileNode,
	#instVars : [
		'agents'
	],
	#category : #'ReMobidyc-Language-File'
}

{ #category : #'instance creation' }
RMDAgentsFileNode class >> agents: anArrayOfRMDAgentDefinitionNode [

	^ self new
		  agents: anArrayOfRMDAgentDefinitionNode;
		  yourself
]

{ #category : #accessing }
RMDAgentsFileNode >> agents [

	^ agents
]

{ #category : #accessing }
RMDAgentsFileNode >> agents: anArrayOfRMDAgentDefinitionNode [

	agents := anArrayOfRMDAgentDefinitionNode
]

{ #category : #enumerating }
RMDAgentsFileNode >> contentsDo: aBlock [

	agents do: aBlock
]

{ #category : #testing }
RMDAgentsFileNode >> isAgentsFileNode [
	^ true
]
