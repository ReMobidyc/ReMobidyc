Class {
	#name : #RMDCellDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDCellDefinitionNode class >> createBuiltinProperties [
	^ {}
]

{ #category : #testing }
RMDCellDefinitionNode >> isCellDefinitionNode [
	^ true
]
