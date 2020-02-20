Class {
	#name : #RMDCellInitializerNode,
	#superclass : #RMDSpeciesInitializerNode,
	#instVars : [
		'xDivisions',
		'yDivisions',
		'size',
		'length'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDCellInitializerNode class >> default [
	^ self
		xDivisions: 1
		yDivisions: 1
		length: '0 [m]' asRMDExpression
		cellPropertyInitializers: Array new
]

{ #category : #'instance creation' }
RMDCellInitializerNode class >> xDivisions: aRMDExpression1 yDivisions: aRMDExpression2 length: aRMDExpression3 cellPropertyInitializers: anArrayOfRMDSimulationCellPropertyDefinitions [
	^ self new
		xDivisions: aRMDExpression1;
		yDivisions: aRMDExpression2;
		size: aRMDExpression3;
		propertyInitializers: anArrayOfRMDSimulationCellPropertyDefinitions;
		yourself
]

{ #category : #enumerating }
RMDCellInitializerNode >> childrenDo: aBlock [
	aBlock value: length.
	propertyInitializers do: aBlock
]

{ #category : #testing }
RMDCellInitializerNode >> isCellInitializerNode [
	^ true
]

{ #category : #accessing }
RMDCellInitializerNode >> length [
	^ length
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
RMDCellInitializerNode >> size [
	^ size
]

{ #category : #accessing }
RMDCellInitializerNode >> size: aRMDLiteralNode [
	size := aRMDLiteralNode.
	length := aRMDLiteralNode type siUnit = RMDUnit m
		ifTrue: [ size numeric ]
		ifFalse: [ aRMDLiteralNode type siUnit = RMDUnit m2
				ifTrue: [ size numeric sqrt ]
				ifFalse: [ nil ] ]
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
