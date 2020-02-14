Class {
	#name : #RMDAnimatDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDAnimatDefinitionNode class >> createBuiltinProperties [
	^ {('x' -> RMDUnit m).
	('y' -> RMDUnit m).
	('heading' -> RMDUnit rad)}
]

{ #category : #'instance creation' }
RMDAnimatDefinitionNode class >> identifier: aString propertyDeclarations: anArrayOfRMDPropertyDeclarationNode [
	^ (self propertyDeclarations: anArrayOfRMDPropertyDeclarationNode)
		identifier: aString;
		yourself
]

{ #category : #testing }
RMDAnimatDefinitionNode >> isAnimatDefinitionNode [
	^ true
]
