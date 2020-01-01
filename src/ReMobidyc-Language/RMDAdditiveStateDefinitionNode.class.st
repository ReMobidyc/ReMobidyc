Class {
	#name : #RMDAdditiveStateDefinitionNode,
	#superclass : #RMDStateDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDAdditiveStateDefinitionNode >> isAdditiveDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDAdditiveStateDefinitionNode >> operator [
	^ '<+'
]
