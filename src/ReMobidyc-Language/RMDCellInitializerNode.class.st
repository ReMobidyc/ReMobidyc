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
RMDCellInitializerNode class >> empty [
	^ self
		xDivisions: 1
		yDivisions: 1
		length: '0 [m]' asRMDExpression
		cellPropertyInitializers: Array new
]

{ #category : #'typical instances' }
RMDCellInitializerNode class >> grassInitializer: xDivisions by: yDivisions of: lengthString grass: minString to: maxString [
	<script:
		'(RMDCellInitializerNode grassInitializer: 10 by: 10 of: ''1[km]'' grass: ''5000[kcal]'' to: ''10000[kcal]'') inspect'>
	^ RMDGrammar new cellInitializer end
		parse:
			(String
				streamContents: [ :stream | 
					xDivisions printOn: stream.
					stream nextPutAll: 'x'.
					yDivisions printOn: stream.
					stream
						nextPutAll: ' of ';
						nextPutAll: lengthString;
						nextPutAll: ' Cell with';
						cr;
						nextPutAll: '    grass = uniform ';
						nextPutAll: minString;
						nextPutAll: ' to ';
						nextPutAll: maxString ])
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

{ #category : #comparing }
RMDCellInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ xDivisions = anObject xDivisions
				and:
					[ yDivisions = anObject yDivisions and: [ size = anObject size ] ] ]
]

{ #category : #enumerating }
RMDCellInitializerNode >> childrenDo: aBlock [
	aBlock value: length.
	propertyInitializers do: aBlock
]

{ #category : #comparing }
RMDCellInitializerNode >> hash [
	^ (((super hash bitXor: xDivisions hash) bitXor: yDivisions hash)
		bitXor: size hash) bitXor: length hash
]

{ #category : #testing }
RMDCellInitializerNode >> isCellInitializerNode [
	^ true
]

{ #category : #accessing }
RMDCellInitializerNode >> length [
	^ length
		ifNil: [ length := size type siUnit = RMDUnit m
				ifTrue: [ size numeric ]
				ifFalse: [ size type siUnit = RMDUnit m2
						ifTrue: [ size numeric sqrt ]
						ifFalse: [ nil ] ] ]
]

{ #category : #copying }
RMDCellInitializerNode >> postCopy [
	super postCopy.
	size := size copy
]

{ #category : #printing }
RMDCellInitializerNode >> printOn: aStream [
	xDivisions printOn: aStream.
	aStream nextPutAll: ' x '.
	yDivisions printOn: aStream.
	aStream nextPutAll: ' cells, '.
	size printOn: aStream.
	aStream nextPutAll: ' each side'.
	propertyInitializers
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyInitializers do: [ :init | init printOn: aStream ] ].
	aStream nextPut: $,
]

{ #category : #rewriting }
RMDCellInitializerNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: size ifPresent: [ :node | size := node copy ].
	length := nil
]

{ #category : #accessing }
RMDCellInitializerNode >> size [
	^ size
]

{ #category : #accessing }
RMDCellInitializerNode >> size: aRMDLiteralNode [
	size := aRMDLiteralNode
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
