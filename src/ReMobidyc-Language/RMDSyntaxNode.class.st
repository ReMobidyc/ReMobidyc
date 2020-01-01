Class {
	#name : #RMDSyntaxNode,
	#superclass : #Object,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDSyntaxNode >> isAdditionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isAdditiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isApplyNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDeltaNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDifferential2Node [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDifferentialNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isDirectDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isFractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isLiteralNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isNextVariableNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isOldNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isPowerNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isProductNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isProductiveDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isStateDefinitionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isSubtractionNode [
	^ false
]

{ #category : #testing }
RMDSyntaxNode >> isVariableNode [
	^ false
]

{ #category : #printing }
RMDSyntaxNode >> printOn: aStream [
	^ self subclassResponsibility
]
