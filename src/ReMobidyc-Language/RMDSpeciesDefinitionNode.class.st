Class {
	#name : #RMDSpeciesDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'propertyDeclarations',
		'utilityDelarations'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDSpeciesDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations [
	^ propertyDeclarations
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations: anArrayOfPropertyDeclaration [
	propertyDeclarations := anArrayOfPropertyDeclaration
]
