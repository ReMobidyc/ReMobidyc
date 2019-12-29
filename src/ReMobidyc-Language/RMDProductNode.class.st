Class {
	#name : #RMDProductNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDProductNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
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
