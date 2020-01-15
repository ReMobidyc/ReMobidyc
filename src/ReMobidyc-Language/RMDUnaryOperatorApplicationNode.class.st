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
	^ '-'
]

{ #category : #printing }
RMDUnaryOperatorApplicationNode >> printOn: aStream [
	aStream nextPutAll: self operator.
	expression printOn: aStream
]
