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
		length: '1 [m]' asRMDExpression
		cellAttributeInitializers: Array new
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
RMDCellInitializerNode class >> xDivisions: aRMDExpression1 yDivisions: aRMDExpression2 length: aRMDExpression3 cellAttributeInitializers: anArrayOfRMDSimulationCellAttributeDefinitions [
	^ self new
		xDivisions: aRMDExpression1;
		yDivisions: aRMDExpression2;
		size: aRMDExpression3;
		attributeInitializers: anArrayOfRMDSimulationCellAttributeDefinitions;
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
	attributeInitializers do: aBlock
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
		ifNil: [ length := size unit siUnit = RMDUnit m
				ifTrue: [ size numeric ]
				ifFalse: [ size unit siUnit = RMDUnit m2
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
	aStream nextPutAll: ' of '.
	size printOn: aStream.
	aStream nextPutAll: ' Cell'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :init | 
				aStream nextPutAll: '    '.
				init printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ]
]

{ #category : #printing }
RMDCellInitializerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	xDivisions
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' x '.
	yDivisions
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' of '.
	size
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' Cell'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :init | 
				aStream nextPutAll: '    '.
				init
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
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
	size := aRMDLiteralNode.
	length := nil
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
