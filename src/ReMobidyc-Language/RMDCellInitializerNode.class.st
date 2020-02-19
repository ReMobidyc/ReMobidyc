Class {
	#name : #RMDCellInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'xDivisions',
		'yDivisions',
		'length',
		'propertyInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDCellInitializerNode class >> xDivisions: aRMDExpression1 yDivisions: aRMDExpression2 length: aRMDExpression3 cellPropertyInitializers: anArrayOfRMDSimulationCellPropertyDefinitions [
	^ self new
		xDivisions: aRMDExpression1;
		yDivisions: aRMDExpression2;
		length: aRMDExpression3;
		propertyInitializers: anArrayOfRMDSimulationCellPropertyDefinitions;
		yourself
]

{ #category : #enumerating }
RMDCellInitializerNode >> childrenDo: aBlock [
	aBlock value: length.
	propertyInitializers do: aBlock
]

{ #category : #testing }
RMDCellInitializerNode >> isSimulationSpaceDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDCellInitializerNode >> length [
	^ length
]

{ #category : #accessing }
RMDCellInitializerNode >> length: aRMDLiteralNode [
	length := aRMDLiteralNode
]

{ #category : #printing }
RMDCellInitializerNode >> printOn: aStream [
	xDivisions printOn: aStream.
	aStream nextPutAll: ' x '.
	yDivisions printOn: aStream.
	aStream nextPutAll: ' cells, '.
	length printOn: aStream.
	aStream nextPutAll: ' each side'.
	propertyInitializers
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyInitializers do: [ :init | init printOn: aStream ] ].
	aStream nextPut: $,
]

{ #category : #accessing }
RMDCellInitializerNode >> propertyInitializers [
	^ propertyInitializers
]

{ #category : #accessing }
RMDCellInitializerNode >> propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	propertyInitializers := anArrayOfRMDSimulationPropertyInitializerNode
]

{ #category : #accessing }
RMDCellInitializerNode >> xDivisions [
	^ xDivisions
]

{ #category : #accessing }
RMDCellInitializerNode >> xDivisions: anInteger [
	xDivisions := anInteger
]

{ #category : #accessing }
RMDCellInitializerNode >> yDivisions [
	^ yDivisions
]

{ #category : #accessing }
RMDCellInitializerNode >> yDivisions: anInteger [
	yDivisions := anInteger
]
