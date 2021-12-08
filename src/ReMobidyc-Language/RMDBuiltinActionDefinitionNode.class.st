Class {
	#name : #RMDBuiltinActionDefinitionNode,
	#superclass : #RMDAbstractActionDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #enumerating }
RMDBuiltinActionDefinitionNode >> childrenDo: aBlock [

	
]

{ #category : #copying }
RMDBuiltinActionDefinitionNode >> postCopy [

	
]

{ #category : #printing }
RMDBuiltinActionDefinitionNode >> printOn: aStream [

	aStream nextPutAll: identifier.
	object ifNotNil: [ 
		aStream
			nextPut: Character space;
			nextPutAll: object ]
]

{ #category : #printing }
RMDBuiltinActionDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: identifier.
	object ifNotNil: [ 
		aStream
			nextPut: Character space;
			nextPutAll: object ].

	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
