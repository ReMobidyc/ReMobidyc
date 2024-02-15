Class {
	#name : #RMDAnimatDefinitionNode,
	#superclass : #RMDAgentDefinitionNode,
	#instVars : [
		'identifier',
		'species'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDAnimatDefinitionNode class >> createBuiltinAttributes [

	^ { 
		  ('x' -> RMDUnit m).
		  ('y' -> RMDUnit m) }
]

{ #category : #'typical instances' }
RMDAnimatDefinitionNode class >> goat [
	<script: 'RMDAnimatDefinitionNode goat inspect'>
	^ RMDGrammar current animatDefinition end parse: 'Goat is Goat with
	blood_sugar [kcal].'
]

{ #category : #'instance creation' }
RMDAnimatDefinitionNode class >> identifier: aString species: anotherString attributeDeclarations: anArrayOfRMDAttributeDeclarationNode utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ (self
		   attributeDeclarations: anArrayOfRMDAttributeDeclarationNode
		   utilityDefinitions: anArrayOfRMDUtilityDefinitionNode)
		  identifier: aString;
		  species: anotherString;
		  yourself
]

{ #category : #'typical instances' }
RMDAnimatDefinitionNode class >> wolf [
	<script: 'RMDAnimatDefinitionNode wolf inspect'>
	^ RMDGrammar current animatDefinition end parse: 'Wolf is Wolf with
	blood_sugar [kcal].'
]

{ #category : #comparing }
RMDAnimatDefinitionNode >> = anObject [
	^ super = anObject and: [ identifier = anObject identifier ]
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> fullName [

	^ self species , '(' , identifier , ')'
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

{ #category : #initialization }
RMDAnimatDefinitionNode >> initialize [

	super initialize.
	species := 'Animat'
]

{ #category : #testing }
RMDAnimatDefinitionNode >> isAnimatDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> name [

	^ identifier
]

{ #category : #printing }
RMDAnimatDefinitionNode >> printOn: aStream [

	aStream
		nextPutAll: identifier;
		nextPutAll: ' is ';
		nextPutAll: species.
	attributeDeclarations ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeDeclarations
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
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
		nextPutAll: ' is ';
		nextPutAll: species.
	attributeDeclarations ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeDeclarations
			do: [ :def | 
				aStream nextPutAll: '    '.
				def
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAnimatDefinitionNode >> renameAnimat: aString to: anotherString [

	identifier = aString ifTrue: [ identifier := anotherString ].
	super renameAnimat: aString to: anotherString
]

{ #category : #rewriting }
RMDAnimatDefinitionNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> species [

	^ species
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> species: aString [

	species := aString
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> xOffset [
	^ 0
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> yOffset [
	^ 1
]
