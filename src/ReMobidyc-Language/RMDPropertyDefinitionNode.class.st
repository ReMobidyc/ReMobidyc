Class {
	#name : #RMDPropertyDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDPropertyDefinitionNode >> isPropertyDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyDefinitionNode >> operator [
	^ '='
]

{ #category : #printing }
RMDPropertyDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: $';
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]
