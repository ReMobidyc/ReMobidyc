Class {
	#name : #RMDSpeciesDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
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

{ #category : #'instance creation' }
RMDSpeciesDefinitionNode class >> default [
	^ self propertyDeclarations: #()
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> flushBuiltinProperties [
	<script:
		'RMDSpeciesDefinitionNode allSubclassesDo: [:c | c flushBuiltinProperties ]'>
	builtinProperties := nil
]

{ #category : #'instance creation' }
RMDSpeciesDefinitionNode class >> propertyDeclarations: anArrayOfRMDPropertyDeclarationNode [
	^ self new
		propertyDeclarations: anArrayOfRMDPropertyDeclarationNode;
		yourself
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ propertyDeclarations = anObject propertyDeclarations ]
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

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> childrenDo: aBlock [
	propertyDeclarations do: aBlock
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> hash [
	^ self class hash bitXor: propertyDeclarations hash
]

{ #category : #testing }
RMDSpeciesDefinitionNode >> isSpeciesDefinitionNode [
	^ true
]

{ #category : #copying }
RMDSpeciesDefinitionNode >> postCopy [
	propertyDeclarations := propertyDeclarations collect: #copy.
	propertyOffsets := nil
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations [
	^ propertyDeclarations
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations: anArrayOfPropertyDeclaration [
	propertyDeclarations := anArrayOfPropertyDeclaration
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> propertyDeclarationsDo: aBlock [
	propertyDeclarations do: aBlock
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> propertyIdentifiersDo: aBlock [
	propertyDeclarations
		do: [ :property | aBlock value: property identifier ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyOffsetAt: aString ifAbsent: errorBlock [
	^ self propertyOffsets at: aString ifAbsent: errorBlock
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

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> propertyOffsetsDo: aBlock [
	self propertyOffsets keysAndValuesDo: aBlock
]

{ #category : #rewriting }
RMDSpeciesDefinitionNode >> replaceChildren: aDictionary [
	propertyDeclarations := propertyDeclarations
		collect: [ :node | node copyReplace: aDictionary ].
	propertyOffsets := nil
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> totalNumberOfProperties [
	^ self builtinProperties size + propertyDeclarations size
]
