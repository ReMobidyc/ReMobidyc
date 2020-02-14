Class {
	#name : #RMDBinaryOperatorApplicationNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression1',
		'expression2'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBinaryOperatorApplicationNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
]

{ #category : #comparing }
RMDBinaryOperatorApplicationNode >> = anObject [
	^ self class = anObject class
		and: [ expression1 = anObject expression1
				and: [ expression2 = anObject expression2 ] ]
]

{ #category : #enumerating }
RMDBinaryOperatorApplicationNode >> childrenDo: aBlock [
	aBlock
		value: expression1;
		value: expression2
]

{ #category : #accessing }
RMDBinaryOperatorApplicationNode >> expression1 [
	^ expression1
]

{ #category : #accessing }
RMDBinaryOperatorApplicationNode >> expression1: aRMDExpression [
	expression1 := aRMDExpression
]

{ #category : #accessing }
RMDBinaryOperatorApplicationNode >> expression2 [
	^ expression2
]

{ #category : #accessing }
RMDBinaryOperatorApplicationNode >> expression2: aRMDExpression [
	expression2 := aRMDExpression
]

{ #category : #comparing }
RMDBinaryOperatorApplicationNode >> hash [
	^ self class hash bitXor: (expression1 hash bitXor: expression2 hash)
]

{ #category : #accessing }
RMDBinaryOperatorApplicationNode >> operator [
	^ self subclassResponsibility
]
