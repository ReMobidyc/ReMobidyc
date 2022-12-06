Class {
	#name : #RMDAgentDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'attributeDeclarations',
		'attributeOffsets',
		'utilityDefinitions'
	],
	#classInstVars : [
		'builtinAttributes'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAgentDefinitionNode class >> attributeDeclarations: anArrayOfRMDAttributeDeclarationNode utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ self new
		  attributeDeclarations: anArrayOfRMDAttributeDeclarationNode;
		  utilityDefinitions: anArrayOfRMDUtilityDefinitionNode;
		  yourself
]

{ #category : #accessing }
RMDAgentDefinitionNode class >> builtinAttributes [
	^ builtinAttributes
		ifNil: [ builtinAttributes := self createBuiltinAttributes ]
]

{ #category : #accessing }
RMDAgentDefinitionNode class >> createBuiltinAttributes [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
RMDAgentDefinitionNode class >> empty [

	^ self attributeDeclarations: Array new utilityDefinitions: Array new
]

{ #category : #accessing }
RMDAgentDefinitionNode class >> flushBuiltinAttributes [

	<script:
	'RMDAgentDefinitionNode allSubclassesDo: [:c | c flushBuiltinAttributes ]'>
	builtinAttributes := nil
]

{ #category : #comparing }
RMDAgentDefinitionNode >> = anObject [

	^ self class = anObject class and: [ 
		  attributeDeclarations = anObject attributeDeclarations and: [ 
			  utilityDefinitions = anObject utilityDefinitions ] ]
]

{ #category : #accessing }
RMDAgentDefinitionNode >> allAttributeDeclarations [
	^ (self builtinAttributes
		collect:
			[ :assoc | RMDAttributeDeclarationNode identifier: assoc key unit: assoc value ])
		, self attributeDeclarations
]

{ #category : #utilities }
RMDAgentDefinitionNode >> asDictionary: anInteger in: aRMDMemory [
	^ (self attributeOffsets associations
		collect: [ :assoc | 
			assoc key
				-> (aRMDMemory at: anInteger + assoc value ifAbsent: [ nil ]) ])
		asDictionary
]

{ #category : #accessing }
RMDAgentDefinitionNode >> attributeDeclarations [
	^ attributeDeclarations
]

{ #category : #accessing }
RMDAgentDefinitionNode >> attributeDeclarations: anArrayOfAttributeDeclaration [
	attributeDeclarations := anArrayOfAttributeDeclaration.
	attributeOffsets := nil
]

{ #category : #enumerating }
RMDAgentDefinitionNode >> attributeDeclarationsDo: aBlock [
	attributeDeclarations do: aBlock
]

{ #category : #enumerating }
RMDAgentDefinitionNode >> attributeIdentifiersDo: aBlock [
	attributeDeclarations
		do: [ :attribute | aBlock value: attribute identifier ]
]

{ #category : #accessing }
RMDAgentDefinitionNode >> attributeOffsetAt: aString ifAbsent: errorBlock [
	^ self attributeOffsets at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDAgentDefinitionNode >> attributeOffsets [
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
RMDAgentDefinitionNode >> attributeOffsetsDo: aBlock [
	self attributeOffsets keysAndValuesDo: aBlock
]

{ #category : #enumerating }
RMDAgentDefinitionNode >> attributeUnitsDo: aBlock [
	self builtinAttributes
		do: [ :assoc | aBlock value: assoc key value: assoc value ].
	self
		attributeDeclarationsDo: [ :decl | aBlock value: decl identifier value: decl unit ]
]

{ #category : #accessing }
RMDAgentDefinitionNode >> builtinAttributes [
	^ self class builtinAttributes
]

{ #category : #enumerating }
RMDAgentDefinitionNode >> childrenDo: aBlock [

	attributeDeclarations do: aBlock.
	utilityDefinitions do: aBlock
]

{ #category : #comparing }
RMDAgentDefinitionNode >> hash [

	^ (self class hash bitXor: attributeDeclarations hash) bitXor:
		  utilityDefinitions hash
]

{ #category : #testing }
RMDAgentDefinitionNode >> isAgentDefinitionNode [
	^ true
]

{ #category : #copying }
RMDAgentDefinitionNode >> postCopy [

	attributeDeclarations := attributeDeclarations collect: #copy.
	attributeOffsets := nil.
	utilityDefinitions := utilityDefinitions collect: #copy
]

{ #category : #rewriting }
RMDAgentDefinitionNode >> replaceChildren: aDictionary [

	attributeDeclarations := attributeDeclarations collect: [ :node | 
		                         node copyReplace: aDictionary ].
	attributeOffsets := nil.
	utilityDefinitions := utilityDefinitions collect: [ :node | 
		                      node copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDAgentDefinitionNode >> totalNumberOfAttributes [
	^ self builtinAttributes size + attributeDeclarations size
]

{ #category : #enumerating }
RMDAgentDefinitionNode >> unitOfAttribute: aString ifAbsent: errorBlock [

	self attributeUnitsDo: [ :identifier :unit | 
		aString = identifier ifTrue: [ ^ unit ] ].
	^ errorBlock value
]

{ #category : #accessing }
RMDAgentDefinitionNode >> utilityDefinitions [

	^ utilityDefinitions
]

{ #category : #accessing }
RMDAgentDefinitionNode >> utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	utilityDefinitions := anArrayOfRMDUtilityDefinitionNode
]
