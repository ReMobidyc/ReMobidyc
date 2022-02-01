Class {
	#name : #RMDSpeciesDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeDeclarations',
		'attributeOffsets'
	],
	#classInstVars : [
		'builtinAttributes'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSpeciesDefinitionNode class >> attributeDeclarations: anArrayOfRMDAttributeDeclarationNode [
	^ self new
		attributeDeclarations: anArrayOfRMDAttributeDeclarationNode;
		yourself
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> builtinAttributes [
	^ builtinAttributes
		ifNil: [ builtinAttributes := self createBuiltinAttributes ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> createBuiltinAttributes [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
RMDSpeciesDefinitionNode class >> empty [
	^ self attributeDeclarations: #()
]

{ #category : #accessing }
RMDSpeciesDefinitionNode class >> flushBuiltinAttributes [
	<script:
		'RMDSpeciesDefinitionNode allSubclassesDo: [:c | c flushBuiltinAttributes ]'>
	builtinAttributes := nil
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> = anObject [
	^ self class = anObject class
		and: [ attributeDeclarations = anObject attributeDeclarations ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> allAttributeDeclarations [
	^ (self builtinAttributes
		collect:
			[ :assoc | RMDAttributeDeclarationNode identifier: assoc key unit: assoc value ])
		, self attributeDeclarations
]

{ #category : #utilities }
RMDSpeciesDefinitionNode >> asDictionary: anInteger in: aRMDMemory [
	^ (self attributeOffsets associations
		collect: [ :assoc | 
			assoc key
				-> (aRMDMemory at: anInteger + assoc value ifAbsent: [ nil ]) ])
		asDictionary
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> attributeDeclarations [
	^ attributeDeclarations
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> attributeDeclarations: anArrayOfAttributeDeclaration [
	attributeDeclarations := anArrayOfAttributeDeclaration.
	attributeOffsets := nil
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> attributeDeclarationsDo: aBlock [
	attributeDeclarations do: aBlock
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> attributeIdentifiersDo: aBlock [
	attributeDeclarations
		do: [ :attribute | aBlock value: attribute identifier ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> attributeOffsetAt: aString ifAbsent: errorBlock [
	^ self attributeOffsets at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> attributeOffsets [
	^ attributeOffsets
		ifNil: [ | offset |
			attributeOffsets := Dictionary new.
			offset := -1.
			self builtinAttributes
				do: [ :assoc | attributeOffsets at: assoc key put: (offset := offset + 1) ].
			attributeDeclarations
				do: [ :declaration | 
					attributeOffsets
						at: declaration identifier
						ifAbsentPut: [ offset := offset + 1 ] ].
			attributeOffsets ]
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> attributeOffsetsDo: aBlock [
	self attributeOffsets keysAndValuesDo: aBlock
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> attributeUnitsDo: aBlock [
	self builtinAttributes
		do: [ :assoc | aBlock value: assoc key value: assoc value ].
	self
		attributeDeclarationsDo: [ :decl | aBlock value: decl identifier value: decl unit ]
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> builtinAttributes [
	^ self class builtinAttributes
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> childrenDo: aBlock [
	attributeDeclarations do: aBlock
]

{ #category : #comparing }
RMDSpeciesDefinitionNode >> hash [
	^ self class hash bitXor: attributeDeclarations hash
]

{ #category : #testing }
RMDSpeciesDefinitionNode >> isSpeciesDefinitionNode [
	^ true
]

{ #category : #copying }
RMDSpeciesDefinitionNode >> postCopy [
	attributeDeclarations := attributeDeclarations collect: #copy.
	attributeOffsets := nil
]

{ #category : #rewriting }
RMDSpeciesDefinitionNode >> replaceChildren: aDictionary [
	attributeDeclarations := attributeDeclarations
		collect: [ :node | node copyReplace: aDictionary ].
	attributeOffsets := nil
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> totalNumberOfAttributes [
	^ self builtinAttributes size + attributeDeclarations size
]

{ #category : #enumerating }
RMDSpeciesDefinitionNode >> unitOfAttribute: aString ifAbsent: errorBlock [

	self attributeUnitsDo: [ :identifier :unit | 
		aString = identifier ifTrue: [ ^ unit ] ].
	^ errorBlock value
]
