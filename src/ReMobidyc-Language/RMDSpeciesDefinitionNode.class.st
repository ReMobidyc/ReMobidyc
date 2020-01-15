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

{ #category : #printing }
RMDSpeciesDefinitionNode >> printOn: aStream [
	identifier printOn: aStream.
	aStream nextPutAll: ' is Animat'.
	propertyDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyDeclarations
				do: [ :def | def printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations [
	^ propertyDeclarations
]

{ #category : #accessing }
RMDSpeciesDefinitionNode >> propertyDeclarations: anArrayOfPropertyDeclaration [
	propertyDeclarations := anArrayOfPropertyDeclaration
]
