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

{ #category : #comparing }
RMDUnaryOperatorApplicationNode >> = anObject [
	^ self class = anObject class
		and: [ expression = anObject expression ]
]

{ #category : #enumerating }
RMDUnaryOperatorApplicationNode >> childrenDo: aBlock [
	aBlock value: expression
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

{ #category : #rewriting }
RMDUnaryOperatorApplicationNode >> replaceChildren: aDictionary [
	expression := expression copyReplace: aDictionary
]
