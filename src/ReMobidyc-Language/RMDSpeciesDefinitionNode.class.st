Class {
	#name : #RMDSpeciesDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'propertyDeclarations',
		'propertyOffsets'
	],
	#classInstVars : [
		'builtinProperties'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> builtinProperties [
	^ builtinProperties
		ifNil: [ builtinProperties := self createBuiltinProperties ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> createBuiltinProperties [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> flushBuiltinProperties [
	<script:
		'RMDSpeciesDefinitionNode allSubclassesDo: [:c | c flushBuiltinProperties ]'>
	builtinProperties := nil
]

{ #category : #'instance creation' }
RMDSpeciesDefinitionNode class >> identifier: aString propertyDeclarations: anArrayOfRMDPropertyDeclarationNode [
	^ self new
		identifier: aString;
		propertyDeclarations: anArrayOfRMDPropertyDeclarationNode;
		yourself
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ propertyDeclarations = anObject propertyDeclarations ] ]
]

{ #category : #utilities }
RMDSpeciesDefinitionNode >> asDictionary: anInteger in: aRMDMemory [
	^ (self propertyOffsets associations
		collect: [ :assoc | 
			assoc key
				-> (aRMDMemory at: anInteger + assoc value ifAbsent: [ nil ]) ])
		asDictionary
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> builtinProperties [
	^ self class builtinProperties
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> hash [
	^ (self class hash bitXor: identifier hash)
		bitXor: propertyDeclarations hash
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #printing }
RMDSpeciesDefinitionNode >> printOn: aStream [
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

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations [
	^ propertyDeclarations
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations: anArrayOfPropertyDeclaration [
	propertyDeclarations := anArrayOfPropertyDeclaration
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyOffsets [
	^ propertyOffsets
		ifNil: [ | offset |
			propertyOffsets := Dictionary new.
			offset := -1.
			self builtinProperties
				do: [ :assoc | propertyOffsets at: assoc key put: (offset := offset + 1) ].
			propertyDeclarations
				do: [ :declaration | 
					propertyOffsets
						at: declaration identifier
						ifAbsentPut: [ offset := offset + 1 ] ].
			propertyOffsets ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> totalNumberOfProperties [
	^ self builtinProperties size + propertyDeclarations size
]
