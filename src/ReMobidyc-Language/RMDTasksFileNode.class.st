Class {
	#name : #RMDTasksFileNode,
	#superclass : #RMDModelFileNode,
	#instVars : [
		'tasks'
	],
	#category : #'ReMobidyc-Language-File'
}

{ #category : #'instance creation' }
RMDTasksFileNode class >> tasks: anArrayOfRMDTaskDefinitionNode [

	^ self new
		  tasks: anArrayOfRMDTaskDefinitionNode;
		  yourself
]

{ #category : #enumerating }
RMDTasksFileNode >> contentsDo: aBlock [

	tasks do: aBlock
]

{ #category : #testing }
RMDTasksFileNode >> isTasksFileNode [

	^ true
]

{ #category : #accessing }
RMDTasksFileNode >> tasks [

	^ tasks
]

{ #category : #accessing }
RMDTasksFileNode >> tasks: anArrayOfRMDTaskDefinitionNode [

	tasks := anArrayOfRMDTaskDefinitionNode
]
