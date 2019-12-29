Class {
	#name : #RMDProductNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression1',
		'expression2'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDProductNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
]

{ #category : #accessing }
RMDProductNode >> expression1 [
	^ expression1
]

{ #category : #accessing }
RMDProductNode >> expression1: aRMDExpression [
	expression1 := aRMDExpression
]

{ #category : #accessing }
RMDProductNode >> expression2 [
	^ expression2
]

{ #category : #accessing }
RMDProductNode >> expression2: aRMDExpression [
	expression2 := aRMDExpression
]

{ #category : #testing }
RMDProductNode >> isProductNode [ 
	^ true
]

{ #category : #accessing }
RMDProductNode >> precedence [
	^ 2
]

{ #category : #printing }
RMDProductNode >> printOn: aStream [
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1 printOn: aStream.
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: '*'.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2 printOn: aStream.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $) ]
]
