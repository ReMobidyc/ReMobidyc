Class {
	#name : #RMDUtilityDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDUtilityDefinitionNode >> isUtilityDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDUtilityDefinitionNode >> operator [
	^ '='
]

{ #category : #printing }
RMDUtilityDefinitionNode >> printOn: aStream [
	variable printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space.
	definitionBody printOn: aStream
]
