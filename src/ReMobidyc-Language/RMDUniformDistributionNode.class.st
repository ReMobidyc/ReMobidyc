Class {
	#name : 'RMDUniformDistributionNode',
	#superclass : 'RMDRandomNode',
	#instVars : [
		'fromExpression',
		'toExpression'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDUniformDistributionNode class >> from: aRMDExpressionNode to: anotherRMDExpressionNode [

	^ self new
		  fromExpression: aRMDExpressionNode;
		  toExpression: anotherRMDExpressionNode;
		  yourself
]

{ #category : 'comparing' }
RMDUniformDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ fromExpression = anObject fromExpression
				and: [ toExpression = anObject toExpression ] ]
]

{ #category : 'enumerating' }
RMDUniformDistributionNode >> childrenDo: aBlock [
	aBlock
		value: fromExpression;
		value: toExpression
]

{ #category : 'enumerating' }
RMDUniformDistributionNode >> childrenTransform: aBlock [

	fromExpression := aBlock value: fromExpression.
	toExpression := aBlock value: toExpression
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> distributionName [

	^ 'uniform'
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> fromExpression [
	^ fromExpression
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> fromExpression: aRMDExpressionNode [
	fromExpression := aRMDExpressionNode
]

{ #category : 'comparing' }
RMDUniformDistributionNode >> hash [
	^ (self class hash bitXor: fromExpression hash) bitXor: toExpression hash
]

{ #category : 'testing' }
RMDUniformDistributionNode >> isUniformDistributionNode [
	^ true
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> parameter1Expression [

	^ self fromExpression
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> parameter2Expression [

	^ self toExpression
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> parameterName [

	^ 'to'
]

{ #category : 'copying' }
RMDUniformDistributionNode >> postCopy [
	fromExpression := fromExpression copy.
	toExpression := toExpression copy
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> precedence [
	^ 10
]

{ #category : 'printing' }
RMDUniformDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'uniform '.
	self precedence <= fromExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	fromExpression printOn: aStream.
	self precedence <= fromExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: ' to '.
	self precedence <= toExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	toExpression printOn: aStream.
	self precedence <= toExpression precedence ifTrue: [ 
		aStream nextPut: $) ]
]

{ #category : 'printing' }
RMDUniformDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'uniform '.
	self precedence <= fromExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	fromExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= fromExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: ' to '.
	self precedence <= toExpression precedence ifTrue: [ 
		aStream nextPut: $( ].
	toExpression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= toExpression precedence ifTrue: [ 
		aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDUniformDistributionNode >> replaceChildren: aDictionary [
	fromExpression := fromExpression copyReplace: aDictionary.
	toExpression := toExpression copyReplace: aDictionary
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> toExpression [
	^ toExpression
]

{ #category : 'accessing' }
RMDUniformDistributionNode >> toExpression: aRMDLiteralNode [
	toExpression := aRMDLiteralNode
]
