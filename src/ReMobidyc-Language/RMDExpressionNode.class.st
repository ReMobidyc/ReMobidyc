Class {
	#name : #RMDExpressionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'type'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDExpressionNode class >> isAbstract [

	^ self == RMDExpressionNode
]

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

{ #category : #private }
RMDExpressionNode >> insertTrace [

	^ RMDTraceNode on: super insertTrace
]

{ #category : #testing }
RMDExpressionNode >> isExpressionNode [
	^ true
]

{ #category : #accessing }
RMDExpressionNode >> precedence [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDExpressionNode >> type [

	^ type
]
