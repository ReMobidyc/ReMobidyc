Class {
	#name : #RMDProductiveStateDefinitionNode,
	#superclass : #RMDStateDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDProductiveStateDefinitionNode >> isProductiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDProductiveStateDefinitionNode >> operator [
	^ '<*'
]
