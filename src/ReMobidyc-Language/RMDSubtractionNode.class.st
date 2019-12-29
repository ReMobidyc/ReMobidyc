Class {
	#name : #RMDSubtractionNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression1',
		'expression2'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDSubtractionNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
]

{ #category : #accessing }
RMDSubtractionNode >> expression1 [
	^ expression1
]

{ #category : #accessing }
RMDSubtractionNode >> expression1: aRMDExpression [
	expression1 := aRMDExpression
]

{ #category : #accessing }
RMDSubtractionNode >> expression2 [
	^ expression2
]

{ #category : #accessing }
RMDSubtractionNode >> expression2: aRMDExpression [
	expression2 := aRMDExpression
]

{ #category : #testing }
RMDSubtractionNode >> isSubtractionNode [
	^ true
]

{ #category : #accessing }
RMDSubtractionNode >> precedence [
	^ 4
]

{ #category : #printing }
RMDSubtractionNode >> printOn: aStream [
	self precedence < expression1 first precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1 first printOn: aStream.
	self precedence < expression1 first precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: '+'.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2 printOn: aStream.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $) ]
]
