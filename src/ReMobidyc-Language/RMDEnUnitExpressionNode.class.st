Class {
	#name : 'RMDEnUnitExpressionNode',
	#superclass : 'RMDCastExpression',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'converting' }
RMDEnUnitExpressionNode >> asPresenter [

	^ RMDEnUnitExpressionPresenter on: self
]

{ #category : 'testing' }
RMDEnUnitExpressionNode >> isEnUnitExpressionNode [

	^ true
]

{ #category : 'accessing' }
RMDEnUnitExpressionNode >> precedence [
	^ 0
]

{ #category : 'printing' }
RMDEnUnitExpressionNode >> printOn: aStream [

	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $( ].
	expression printOn: aStream.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: '['.
	unit printOn: aStream.
	aStream nextPutAll: ']'
]

{ #category : 'printing' }
RMDEnUnitExpressionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $( ].
	expression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: '['.
	unit printOn: aStream.
	aStream nextPutAll: ']'.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
