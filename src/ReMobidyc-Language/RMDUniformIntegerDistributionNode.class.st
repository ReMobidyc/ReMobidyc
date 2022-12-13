Class {
	#name : #RMDUniformIntegerDistributionNode,
	#superclass : #RMDUniformDistributionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDUniformIntegerDistributionNode >> isUniformIntegerDistributionNode [

	^ true
]

{ #category : #printing }
RMDUniformIntegerDistributionNode >> printOn: aStream [

	aStream nextPutAll: 'uniform_integer '.
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

{ #category : #printing }
RMDUniformIntegerDistributionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'uniform_integer '.
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
