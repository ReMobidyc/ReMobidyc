Class {
	#name : #RMDUnaryOperatorApplicationNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUnaryOperatorApplicationNode class >> expression: aRMDExpressionNode [
	^ self new
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #testing }
RMDUnaryOperatorApplicationNode class >> isAbstract [

	^ self == RMDUnaryOperatorApplicationNode
]

{ #category : #comparing }
RMDUnaryOperatorApplicationNode >> = anObject [
	^ self class = anObject class
		and: [ expression = anObject expression ]
]

{ #category : #converting }
RMDUnaryOperatorApplicationNode >> asPresenter [

	^ RMDUnaryOperatorExpressionPresenter on: self
]

{ #category : #enumerating }
RMDUnaryOperatorApplicationNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #enumerating }
RMDUnaryOperatorApplicationNode >> childrenTransform: aBlock [

	expression := aBlock value: expression
]

{ #category : #accessing }
RMDUnaryOperatorApplicationNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDUnaryOperatorApplicationNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDUnaryOperatorApplicationNode >> hash [
	^ self class hash bitXor: expression hash
]

{ #category : #accessing }
RMDUnaryOperatorApplicationNode >> operator [
	^ self subclassResponsibility
]

{ #category : #copying }
RMDUnaryOperatorApplicationNode >> postCopy [
	expression := expression copy
]

{ #category : #printing }
RMDUnaryOperatorApplicationNode >> printOn: aStream [
	aStream nextPutAll: self operator.
	self precedence < expression precedence
		ifTrue: [ aStream nextPut: $( ].
	expression printOn: aStream.
	self precedence < expression precedence
		ifTrue: [ aStream nextPut: $) ]
]

{ #category : #printing }
RMDUnaryOperatorApplicationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: self operator.
	self precedence < expression precedence
		ifTrue: [ aStream nextPut: $( ].
	expression
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence < expression precedence
		ifTrue: [ aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDUnaryOperatorApplicationNode >> replaceChildren: aDictionary [
	expression := expression copyReplace: aDictionary
]
