Class {
	#name : #RMDPropertyProductiveDefinitionNode,
	#superclass : #RMDPropertyDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDPropertyProductiveDefinitionNode >> isPropertyProductiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyProductiveDefinitionNode >> operator [
	^ '<*'
]
