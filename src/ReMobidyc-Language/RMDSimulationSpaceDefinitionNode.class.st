Class {
	#name : #RMDSimulationSpaceDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'xDivisions',
		'yDivisions',
		'length',
		'cellPropertyDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSimulationSpaceDefinitionNode class >> xDivisions: aRMDExpression1 yDivisions: aRMDExpression2 length: aRMDExpression3 cellPropertyDefinitions: anArrayOfRMDSimulationCellPropertyDefinitions [
	^ self new
		xDivisions: aRMDExpression1;
		yDivisions: aRMDExpression2;
		length: aRMDExpression3;
		propertyDefinitions: anArrayOfRMDSimulationCellPropertyDefinitions;
		yourself
]

{ #category : #enumerating }
RMDSimulationSpaceDefinitionNode >> childrenDo: aBlock [
	aBlock value: length
]

{ #category : #testing }
RMDSimulationSpaceDefinitionNode >> isSimulationSpaceDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> length [
	^ length
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> length: aRMDLiteralNode [
	length := aRMDLiteralNode
]

{ #category : #printing }
RMDSimulationSpaceDefinitionNode >> printOn: aStream [
	xDivisions printOn: aStream.
	aStream nextPutAll: ' x '.
	yDivisions printOn: aStream.
	aStream nextPutAll: ' cells, '.
	length printOn: aStream.
	aStream nextPutAll: ' each side'.
	cellPropertyDefinitions
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			cellPropertyDefinitions do: [ :init | init printOn: aStream ] ].
	aStream nextPut: $,
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> propertyDefinitions [
	^ cellPropertyDefinitions
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> propertyDefinitions: anArrayOfRMDSimulationPropertyDefinitionNode [
	cellPropertyDefinitions := anArrayOfRMDSimulationPropertyDefinitionNode
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> xDivisions [
	^ xDivisions
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> xDivisions: anInteger [
	xDivisions := anInteger
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> yDivisions [
	^ yDivisions
]

{ #category : #accessing }
RMDSimulationSpaceDefinitionNode >> yDivisions: anInteger [
	yDivisions := anInteger
]
