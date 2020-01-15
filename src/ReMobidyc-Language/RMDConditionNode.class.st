Class {
	#name : #RMDConditionNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDConditionNode >> precedence [
	^ self subclassResponsibility
]
