Class {
	#name : #RMDExpressionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #arithmetics }
RMDExpressionNode >> * aRMDExpression [
	^ RMDProductNode expression: self expression: aRMDExpression
]

{ #category : #arithmetics }
RMDExpressionNode >> / aRMDExpression [
	^ RMDFractionNode expression: self expression: aRMDExpression
]

{ #category : #accessing }
RMDExpressionNode >> precedence [
	^ self subclassResponsibility
]
