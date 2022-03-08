Class {
	#name : #RMDNormalDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'meanLiteral',
		'sigmaLiteral'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNormalDistributionNode class >> mean: aRMDLiteral sigma: anotherRMDLiteral [

	^ self new
		  meanLiteral: aRMDLiteral;
		  sigmaLiteral: anotherRMDLiteral;
		  yourself
]

{ #category : #comparing }
RMDNormalDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ meanLiteral = anObject meanLiteral
				and: [ sigmaLiteral = anObject sigmaLiteral ] ]
]

{ #category : #enumerating }
RMDNormalDistributionNode >> childrenDo: aBlock [
	aBlock
		value: meanLiteral;
		value: sigmaLiteral
]

{ #category : #comparing }
RMDNormalDistributionNode >> hash [
	^ (self class hash bitXor: meanLiteral hash) bitXor: sigmaLiteral hash
]

{ #category : #testing }
RMDNormalDistributionNode >> isNormalDistributionNode [
	^ true
]

{ #category : #accessing }
RMDNormalDistributionNode >> meanLiteral [

	^ meanLiteral
]

{ #category : #accessing }
RMDNormalDistributionNode >> meanLiteral: aRMDLiteralNode [

	meanLiteral := aRMDLiteralNode
]

{ #category : #copying }
RMDNormalDistributionNode >> postCopy [
	meanLiteral := meanLiteral copy.
	sigmaLiteral := sigmaLiteral copy
]

{ #category : #accessing }
RMDNormalDistributionNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDNormalDistributionNode >> printOn: aStream [
	aStream nextPutAll: 'normal '.
	meanLiteral printOn: aStream.
	aStream nextPutAll: ' sigma '.
	sigmaLiteral printOn: aStream
]

{ #category : #printing }
RMDNormalDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'normal '.
	meanLiteral
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' mean '.
	sigmaLiteral
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDNormalDistributionNode >> replaceChildren: aDictionary [
	meanLiteral := meanLiteral copyReplace: aDictionary.
	sigmaLiteral := sigmaLiteral copyReplace: aDictionary
]

{ #category : #accessing }
RMDNormalDistributionNode >> sigmaLiteral [

	^ sigmaLiteral
]

{ #category : #accessing }
RMDNormalDistributionNode >> sigmaLiteral: aRMDLiteralNode [

	sigmaLiteral := aRMDLiteralNode
]
