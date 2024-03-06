Class {
	#name : #RMDPowerNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression',
		'order'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPowerNode class >> expression: aRMDExpression order: anInteger [
	^ self new
		expression: aRMDExpression;
		order: anInteger;
		yourself
]

{ #category : #comparing }
RMDPowerNode >> = anObject [
	^ self class = anObject class
		and: [ expression = anObject expression
				and: [ order = anObject order ] ]
]

{ #category : #enumerating }
RMDPowerNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #enumerating }
RMDPowerNode >> childrenTransform: aBlock [

	expression := aBlock value: expression
]

{ #category : #accessing }
RMDPowerNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPowerNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDPowerNode >> hash [
	^ self class hash bitXor: (expression hash bitXor: order hash)
]

{ #category : #testing }
RMDPowerNode >> isPowerNode [
	^ true
]

{ #category : #accessing }
RMDPowerNode >> operator [
	^ '^'
]

{ #category : #accessing }
RMDPowerNode >> order [
	^ order
]

{ #category : #accessing }
RMDPowerNode >> order: anInteger [
	order := anInteger
]

{ #category : #copying }
RMDPowerNode >> postCopy [
	expression := expression copy
]

{ #category : #accessing }
RMDPowerNode >> precedence [
	^ 2
]

{ #category : #printing }
RMDPowerNode >> printOn: aStream [

	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $( ].
	expression printOn: aStream.
	self precedence < expression precedence ifTrue: [ 
		aStream nextPut: $) ].
	aStream nextPutAll: self operator.
	order printOn: aStream
]

{ #category : #printing }
RMDPowerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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
	aStream nextPutAll: self operator.
	order printOn: aStream.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDPowerNode >> replaceChildren: aDictionary [
	expression := expression copyReplace: aDictionary
]
