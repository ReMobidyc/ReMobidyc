Class {
	#name : #RMDAnimatDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDAnimatDefinitionNode class >> createBuiltinProperties [
	^ {('x' -> RMDUnit m).
	('y' -> RMDUnit m)}
]

{ #category : #'instance creation' }
RMDAnimatDefinitionNode class >> default [
	^ self identifier: 'Default' propertyDeclarations: Array new
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
