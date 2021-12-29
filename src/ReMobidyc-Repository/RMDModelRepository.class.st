Class {
	#name : #RMDModelRepository,
	#superclass : #RMDRepository,
	#instVars : [
		'simulationModel'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'instance creation' }
RMDModelRepository class >> on: aRMDSimulationModel [
	^ self new
		simulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #accessing }
RMDModelRepository >> actionIdentifiers [
	^ self actionNames
		collect: [ :actionName | RMDLocalActionIdentifierNode identifier: actionName ]
]

{ #category : #accessing }
RMDModelRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ simulationModel
		ifNotNil: [ simulationModel actionNamed: aString ifAbsent: errorBlock ]
		ifNil: errorBlock
]

{ #category : #accessing }
RMDModelRepository >> actionNames [
	^ simulationModel ifNotNil: #actionNames ifNil: [ Array new ]
]

{ #category : #testing }
RMDModelRepository >> includesActionIdentifier: aRMDActionIdentifierNode [
	^ aRMDActionIdentifierNode isLocalActionIdentifierNode
		and: [ super includesActionIdentifier: aRMDActionIdentifierNode ]
]

{ #category : #testing }
RMDModelRepository >> isModifiable [

	^ true
]

{ #category : #accessing }
RMDModelRepository >> repositoryName [
	^ 'Model' copy
]

{ #category : #accessing }
RMDModelRepository >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDModelRepository >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]
