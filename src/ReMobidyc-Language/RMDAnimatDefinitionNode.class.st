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

{ #category : #testing }
RMDAnimatDefinitionNode >> isAnimatDefinitionNode [
	^ true
]
