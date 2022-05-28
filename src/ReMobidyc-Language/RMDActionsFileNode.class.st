Class {
	#name : #RMDActionsFileNode,
	#superclass : #RMDModelFileNode,
	#instVars : [
		'actions'
	],
	#category : #'ReMobidyc-Language-File'
}

{ #category : #'instance creation' }
RMDActionsFileNode class >> actions: anArrayOfRMDActionDefinitionNode [

	^ self new
		  actions: anArrayOfRMDActionDefinitionNode;
		  yourself
]

{ #category : #accessing }
RMDActionsFileNode >> actions [

	^ actions
]

{ #category : #accessing }
RMDActionsFileNode >> actions: anArrayOfRMDActionDefinitionNode [

	actions := anArrayOfRMDActionDefinitionNode
]

{ #category : #enumerating }
RMDActionsFileNode >> contentsDo: aBlock [

	actions do: aBlock
]

{ #category : #testing }
RMDActionsFileNode >> isActionsFileNode [
	^ true
]
