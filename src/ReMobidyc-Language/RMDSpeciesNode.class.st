Class {
	#name : #RMDSpeciesNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'propertyDeclarations'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDSpeciesNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDSpeciesNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDSpeciesNode >> propertyDeclarations [
	^ propertyDeclarations
]

{ #category : #accessing }
RMDSpeciesNode >> propertyDeclarations: anArrayOfPropertyDeclaration [
	propertyDeclarations := anArrayOfPropertyDeclaration
]
