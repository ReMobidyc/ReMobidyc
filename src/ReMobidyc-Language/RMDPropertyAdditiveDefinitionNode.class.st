Class {
	#name : #RMDPropertyAdditiveDefinitionNode,
	#superclass : #RMDPropertyDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDPropertyAdditiveDefinitionNode >> isPropertyAdditiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyAdditiveDefinitionNode >> operator [
	^ '<+'
]
