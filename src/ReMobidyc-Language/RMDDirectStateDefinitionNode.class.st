Class {
	#name : #RMDDirectStateDefinitionNode,
	#superclass : #RMDStateDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDirectStateDefinitionNode >> isDirectDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDDirectStateDefinitionNode >> operator [
	^ '='
]
