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
RMDExpressionNode >> + aRMDExpression [
	^ RMDAdditionNode expression: self expression: aRMDExpression
]

{ #category : #arithmetics }
RMDExpressionNode >> - aRMDExpression [
	^ RMDSubtractionNode expression: self expression: aRMDExpression
]

{ #category : #arithmetics }
RMDExpressionNode >> / aRMDExpression [
	^ RMDFractionNode expression: self expression: aRMDExpression
]

{ #category : #accessing }
RMDExpressionNode >> precedence [
	^ self subclassResponsibility
]
