Class {
	#name : #RMDAttributeDeclarationNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'unit'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAttributeDeclarationNode class >> identifier: aString unit: aRMDUnit [
	^ self new
		identifier: aString;
		unit: aRMDUnit;
		yourself
]

{ #category : #comparing }
RMDAttributeDeclarationNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ unit = anObject unit ] ]
]

{ #category : #converting }
RMDAttributeDeclarationNode >> asPresenter [
	^ RMDAttributeDeclarationPresenter on: self
]

{ #category : #enumerating }
RMDAttributeDeclarationNode >> childrenDo: aBlock [

]

{ #category : #comparing }
RMDAttributeDeclarationNode >> hash [
	^ (self class hash bitXor: identifier hash) bitXor: unit hash
]

{ #category : #accessing }
RMDAttributeDeclarationNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAttributeDeclarationNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDAttributeDeclarationNode >> isAttributeDeclarationNode [
	^ true
]

{ #category : #copying }
RMDAttributeDeclarationNode >> postCopy [
	
]

{ #category : #printing }
RMDAttributeDeclarationNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' ['.
	unit printOn: aStream.
	aStream nextPut: $]
]

{ #category : #printing }
RMDAttributeDeclarationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: identifier;
		nextPutAll: ' ['.
	unit printOn: aStream.
	aStream nextPut: $].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAttributeDeclarationNode >> replaceChildren: aDictionary [
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	aDictionary at: unit ifPresent: [ :node | unit := node copy ]
]

{ #category : #accessing }
RMDAttributeDeclarationNode >> unit [
	^ unit
]

{ #category : #accessing }
RMDAttributeDeclarationNode >> unit: anRMDUnit [
	unit := anRMDUnit
]
