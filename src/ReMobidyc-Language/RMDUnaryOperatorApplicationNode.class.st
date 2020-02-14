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

{ #category : #accessing }
RMDUnaryOperatorApplicationNode >> operator [
	^ self subclassResponsibility
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
