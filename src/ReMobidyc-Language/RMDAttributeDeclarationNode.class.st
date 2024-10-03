Class {
	#name : 'RMDAttributeDeclarationNode',
	#superclass : 'RMDSyntaxNode',
	#instVars : [
		'identifier',
		'unit',
		'initializerExpression'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDAttributeDeclarationNode class >> identifier: aString unit: aRMDUnit [

	^ self identifier: aString unit: aRMDUnit initializerExpression: nil
]

{ #category : 'instance creation' }
RMDAttributeDeclarationNode class >> identifier: aString unit: aRMDUnit initializerExpression: aRMDExpression [

	^ self new
		  identifier: aString;
		  unit: aRMDUnit;
		  initializerExpression: aRMDExpression;
		  yourself
]

{ #category : 'typical instances' }
RMDAttributeDeclarationNode class >> template [

	^ self identifier: '' unit: RMDUnit noDimension
]

{ #category : 'comparing' }
RMDAttributeDeclarationNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier and: [ 
			  unit = anObject unit and: [ 
				  initializerExpression = anObject initializerExpression ] ] ]
]

{ #category : 'converting' }
RMDAttributeDeclarationNode >> asAttributeInitializerNode [
	^ RMDAttributeInitializerNode identifier: self identifier expression: (self initializerExpression ifNil: [
	RMDLiteralNode literal: '0.0' unit: self unit ])
]

{ #category : 'converting' }
RMDAttributeDeclarationNode >> asPresenter [
	^ RMDAttributeDeclarationPresenter on: self
]

{ #category : 'enumerating' }
RMDAttributeDeclarationNode >> childrenDo: aBlock [

	initializerExpression ifNotNil: [ 
		aBlock value: initializerExpression ]
]

{ #category : 'enumerating' }
RMDAttributeDeclarationNode >> childrenTransform: aBlock [

	initializerExpression ifNotNil: [
		initializerExpression := aBlock value: initializerExpression ]
]

{ #category : 'testing' }
RMDAttributeDeclarationNode >> hasInitializer [

	^ initializerExpression notNil
]

{ #category : 'comparing' }
RMDAttributeDeclarationNode >> hash [

	^ ((self class hash bitXor: identifier hash) bitXor: unit hash) 
		  bitXor: initializerExpression hash
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> identifier [
	^ identifier
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> identifier: aString [
	identifier := aString
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> initializerExpression [

	^ initializerExpression
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> initializerExpression: aRMDExpression [

	initializerExpression := aRMDExpression
]

{ #category : 'testing' }
RMDAttributeDeclarationNode >> isAttributeDeclarationNode [
	^ true
]

{ #category : 'testing' }
RMDAttributeDeclarationNode >> isCorrectSyntax [

	^ (RMDGrammar current attributeDeclaration end parse:
		   self printString) = self
]

{ #category : 'testing' }
RMDAttributeDeclarationNode >> isCorrectTypeWithSubject: aString in: aRMDSimulationModel [

	| agentDefinition |
	agentDefinition := aRMDSimulationModel
		                   agentDefinitionAt: aString
		                   ifAbsent: [ ^ false ].
	[
	aRMDSimulationModel typechecker
		typecheck: self
		subject: aString
		object: nil
		utilities: agentDefinition utilityDefinitions ]
		on: RMDError
		do: [ :ex | ^ false ].
	^ (agentDefinition attributeDeclarations contains: [
		   :attributeDeclaration |
		   attributeDeclaration ~~ self and: [
			   attributeDeclaration identifier = self identifier ] ]) not
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> nameWithUnit [

	^ String streamContents: [ :stream | 
		  identifier ifNotNil: [ stream nextPutAll: identifier ].
		  stream nextPutAll: ' ['.
		  unit ifNotNil: [ unit printOn: stream ].
		  stream nextPutAll: ']' ]
]

{ #category : 'copying' }
RMDAttributeDeclarationNode >> postCopy [

	initializerExpression := initializerExpression ifNotNil: #copy
]

{ #category : 'printing' }
RMDAttributeDeclarationNode >> printOn: aStream [

	aStream
		nextPutAll: identifier;
		nextPutAll: ' ['.
	unit printOn: aStream.
	aStream nextPut: $].
	initializerExpression ifNotNil: [ 
		aStream nextPutAll: ' = '.
		initializerExpression printOn: aStream ]
]

{ #category : 'printing' }
RMDAttributeDeclarationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: identifier;
		nextPutAll: ' ['.
	unit printOn: aStream.
	aStream nextPut: $].
	initializerExpression ifNotNil: [ 
		aStream nextPutAll: ' = '.
		initializerExpression
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'printing' }
RMDAttributeDeclarationNode >> printShortOn: aStream [

	aStream
		nextPutAll: 'Attribute definition of ';
		nextPutAll: self identifier
]

{ #category : 'rewriting' }
RMDAttributeDeclarationNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	aDictionary at: unit ifPresent: [ :node | unit := node copy ].
	initializerExpression ifNotNil: [ 
		initializerExpression := initializerExpression copyReplace:
			                         aDictionary ]
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> unit [
	^ unit
]

{ #category : 'accessing' }
RMDAttributeDeclarationNode >> unit: anRMDUnit [
	unit := anRMDUnit
]
