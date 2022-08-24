Class {
	#name : #RMDNormalDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'sigmaExpression',
		'meanExpression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNormalDistributionNode class >> mean: aRMDLiteral sigma: anotherRMDLiteral [

	^ self new
		  meanExpression: aRMDLiteral;
		  sigmaExpression: anotherRMDLiteral;
		  yourself
]

{ #category : #comparing }
RMDNormalDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ meanExpression = anObject meanExpression
				and: [ sigmaExpression = anObject sigmaExpression ] ]
]

{ #category : #enumerating }
RMDNormalDistributionNode >> childrenDo: aBlock [
	aBlock
		value: meanExpression;
		value: sigmaExpression
]

{ #category : #comparing }
RMDNormalDistributionNode >> hash [
	^ (self class hash bitXor: meanExpression hash) bitXor: sigmaExpression hash
]

{ #category : #testing }
RMDNormalDistributionNode >> isNormalDistributionNode [
	^ true
]

{ #category : #accessing }
RMDNormalDistributionNode >> meanExpression [

	^ meanExpression
]

{ #category : #accessing }
RMDNormalDistributionNode >> meanExpression: aRMDExpressionNode [

	meanExpression := aRMDExpressionNode
]

{ #category : #copying }
RMDNormalDistributionNode >> postCopy [
	meanExpression := meanExpression copy.
	sigmaExpression := sigmaExpression copy
]

{ #category : #accessing }
RMDNormalDistributionNode >> precedence [
	^ 10
]

{ #category : #printing }
RMDNormalDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'normal '.
	self precedence <= meanExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	meanExpression printOn: aStream.
	self precedence <= meanExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: ' sigma '.
	self precedence <= sigmaExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	sigmaExpression printOn: aStream.
	self precedence <= sigmaExpression precedence ifTrue: [ 
		aStream nextPut: $) ]
]

{ #category : #printing }
RMDNormalDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'normal '.
	self precedence <= meanExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	meanExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= meanExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: ' sigma '.
	self precedence <= sigmaExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	sigmaExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= sigmaExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDNormalDistributionNode >> replaceChildren: aDictionary [
	meanExpression := meanExpression copyReplace: aDictionary.
	sigmaExpression := sigmaExpression copyReplace: aDictionary
]

{ #category : #accessing }
RMDNormalDistributionNode >> sigmaExpression [

	^ sigmaExpression
]

{ #category : #accessing }
RMDNormalDistributionNode >> sigmaExpression: aRMDExpressionNode [

	sigmaExpression := aRMDExpressionNode
]
