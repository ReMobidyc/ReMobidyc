Class {
	#name : #RMDDeUnitExpressionNode,
	#superclass : #RMDCastExpression,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDeUnitExpressionNode >> isDeUnitExpressionNode [

	^ true
]

{ #category : #accessing }
RMDDeUnitExpressionNode >> precedence [
	^ 0.1
]

{ #category : #printing }
RMDDeUnitExpressionNode >> printOn: aStream [

	aStream nextPutAll: '('.
	unit printOn: aStream.
	aStream nextPutAll: ')'.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $( ].
	expression printOn: aStream.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $) ]
]

{ #category : #printing }
RMDDeUnitExpressionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: '('.
	unit printOn: aStream.
	aStream nextPutAll: ')'.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $( ].
	expression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
