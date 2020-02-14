Class {
	#name : #RMDWorldDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDWorldDefinitionNode class >> createBuiltinProperties [
	^ {}
]

{ #category : #testing }
RMDWorldDefinitionNode >> isWorldDefinitionNode [
	^ true
]
