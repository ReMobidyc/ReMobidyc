Class {
	#name : #RMDPropertyDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDPropertyDefinitionNode >> isPropertyDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyDefinitionNode >> operator [
	^ '='
]
