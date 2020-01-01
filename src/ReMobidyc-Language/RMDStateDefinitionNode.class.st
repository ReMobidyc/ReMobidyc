Class {
	#name : #RMDStateDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDStateDefinitionNode >> isStateDefinitionNode [
	^ true
]

{ #category : #printing }
RMDStateDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: $';
		nextPut: Character space.
	type
		ifNotNil: [ aStream nextPut: Character space.
			type printOn: aStream ].
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]
