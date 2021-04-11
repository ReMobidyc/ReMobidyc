Class {
	#name : #RMDProductNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDProductNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
]

{ #category : #'type checking' }
RMDProductNode >> inferType [
	| type1 type2 |
	type1 := expression1 inferType.
	type2 := expression2 inferType.
	(type1 notNil and: [ type2 notNil ])
		ifTrue: [ self unifyType: type1 * type2 ].
	^ type
]

{ #category : #testing }
RMDProductNode >> isProductNode [ 
	^ true
]

{ #category : #accessing }
RMDProductNode >> operator [
	^ '*'
]

{ #category : #accessing }
RMDProductNode >> precedence [
	^ 3
]
