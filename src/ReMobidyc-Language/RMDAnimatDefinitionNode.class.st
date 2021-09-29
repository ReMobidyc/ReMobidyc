Class {
	#name : #RMDAnimatDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'typical instances' }
RMDAnimatDefinitionNode class >> ant [
	<script: 'RMDAnimatDefinitionNode ant inspect'>
	^ RMDGrammar new animatDefinition end parse: 'Ant is Animat with
	sugar [kcal].'
]

{ #category : #accessing }
RMDAnimatDefinitionNode class >> createBuiltinProperties [
	^ {('x' -> RMDUnit m).
	('y' -> RMDUnit m)}
]

{ #category : #'typical instances' }
RMDAnimatDefinitionNode class >> goat [
	<script: 'RMDAnimatDefinitionNode goat inspect'>
	^ RMDGrammar new animatDefinition end parse: 'Goat is Animat with
	blood_sugar [kcal].'
]

{ #category : #'instance creation' }
RMDAnimatDefinitionNode class >> identifier: aString propertyDeclarations: anArrayOfRMDPropertyDeclarationNode [
	^ (self propertyDeclarations: anArrayOfRMDPropertyDeclarationNode)
		identifier: aString;
		yourself
]

{ #category : #comparing }
RMDAnimatDefinitionNode >> = anObject [
	^ super = anObject and: [ identifier = anObject identifier ]
]

{ #category : #comparing }
RMDAnimatDefinitionNode >> hash [
	^ super hash bitXor: identifier hash
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDAnimatDefinitionNode >> isAnimatDefinitionNode [
	^ true
]

{ #category : #printing }
RMDAnimatDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' is Animat'.
	propertyDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyDeclarations
				do: [ :def | 
					aStream nextPutAll: '    '.
					def printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDAnimatDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: identifier;
		nextPutAll: ' is Animat'.
	propertyDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyDeclarations
				do: [ :def | 
					aStream nextPutAll: '    '.
					def
						printOn: aStream
						ifIncludedIn: aCollectionOfRMDSyntaxNode
						addSectionTo: aCollection ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAnimatDefinitionNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> xOffset [
	^ 0
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> yOffset [
	^ 1
]
