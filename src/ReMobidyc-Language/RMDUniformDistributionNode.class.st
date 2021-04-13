Class {
	#name : #RMDUniformDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'fromLiteral',
		'toLiteral'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUniformDistributionNode class >> from: aRMDLiteral to: anotherRMDLiteral [
	^ self new
		fromLiteral: aRMDLiteral;
		toLiteral: anotherRMDLiteral;
		yourself
]

{ #category : #comparing }
RMDUniformDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ fromLiteral = anObject fromLiteral
				and: [ toLiteral = anObject toLiteral ] ]
]

{ #category : #enumerating }
RMDUniformDistributionNode >> childrenDo: aBlock [
	aBlock
		value: fromLiteral;
		value: toLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral [
	^ fromLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral: aRMDLiteralNode [
	fromLiteral := aRMDLiteralNode
]

{ #category : #comparing }
RMDUniformDistributionNode >> hash [
	^ (self class hash bitXor: fromLiteral hash) bitXor: toLiteral hash
]

{ #category : #testing }
RMDUniformDistributionNode >> isUniformDistributionNode [
	^ true
]

{ #category : #copying }
RMDUniformDistributionNode >> postCopy [
	fromLiteral := fromLiteral copy.
	toLiteral := toLiteral copy
]

{ #category : #accessing }
RMDUniformDistributionNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDUniformDistributionNode >> printOn: aStream [
	aStream nextPutAll: 'uniform '.
	fromLiteral printOn: aStream.
	aStream nextPutAll: ' to '.
	toLiteral printOn: aStream
]

{ #category : #printing }
RMDUniformDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'uniform '.
	fromLiteral
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' to '.
	toLiteral
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDUniformDistributionNode >> replaceChildren: aDictionary [
	fromLiteral := fromLiteral copyReplace: aDictionary.
	toLiteral := toLiteral copyReplace: aDictionary
]

{ #category : #accessing }
RMDUniformDistributionNode >> toLiteral [
	^ toLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> toLiteral: aRMDLiteralNode [
	toLiteral := aRMDLiteralNode
]
