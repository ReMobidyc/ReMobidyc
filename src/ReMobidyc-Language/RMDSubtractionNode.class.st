Class {
	#name : #RMDSubtractionNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDSubtractionNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		expression1: aRMDExpression1;
		expression2: aRMDExpression2;
		yourself
]

{ #category : #'type checking' }
RMDSubtractionNode >> inferType [
	self
		unifyType: expression1 inferType;
		unifyType: expression2 inferType.
	^ type
]

{ #category : #testing }
RMDSubtractionNode >> isSubtractionNode [
	^ true
]

{ #category : #accessing }
RMDSubtractionNode >> operator [
	^ '-'
]

{ #category : #accessing }
RMDSubtractionNode >> precedence [
	^ 5
]
