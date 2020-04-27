Class {
	#name : #RMDAnimatDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#instVars : [
		'identifier'
	],
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

{ #category : #comparing }
RMDAnimatDefinitionNode >> = anObject [
	^ super = anObject and: [ identifier = anObject identifier ]
]

{ #category : #comparing }
RMDAnimatDefinitionNode >> hash [
	^ super hash bitXor: identifier hash
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDAnimatDefinitionNode >> isAnimatDefinitionNode [
	^ true
]

{ #category : #printing }
RMDAnimatDefinitionNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' is Animat'.
	propertyDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyDeclarations
				do: [ :def | 
					aStream nextPutAll: '    '.
					def printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #rewriting }
RMDAnimatDefinitionNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> xOffset [
	^ 0
]

{ #category : #accessing }
RMDAnimatDefinitionNode >> yOffset [
	^ 1
]
