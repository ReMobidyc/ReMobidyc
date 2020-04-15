Class {
	#name : #RMDExpressionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
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

{ #category : #testing }
RMDExpressionNode >> isExpressionNode [
	^ true
]

{ #category : #accessing }
RMDExpressionNode >> precedence [
	^ self subclassResponsibility
]

{ #category : #rewriting }
RMDExpressionNode >> replace: aDictionary [
	^ aDictionary
		at: self
		ifAbsent: [ self replaceChildren: aDictionary ]
]

{ #category : #rewriting }
RMDExpressionNode >> replaceChildren: aDictionary [
	^ self subclassResponsibility
]
