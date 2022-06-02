Class {
	#name : #RMDWorldDefinitionNode,
	#superclass : #RMDAgentDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDWorldDefinitionNode class >> createBuiltinAttributes [

	^ {  }
]

{ #category : #'typical instances' }
RMDWorldDefinitionNode class >> empty [
	<script: 'RMDWorldDefinitionNode empty inspect'>
	^ self attributeDeclarations: {}
]

{ #category : #testing }
RMDWorldDefinitionNode >> isWorldDefinitionNode [
	^ true
]

{ #category : #printing }
RMDWorldDefinitionNode >> printOn: aStream [
	aStream nextPutAll: 'World'.
	attributeDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			attributeDeclarations
				do: [ :def | 
					aStream nextPutAll: '    '.
					def printOn: aStream ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDWorldDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'World'.
	attributeDeclarations
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			attributeDeclarations
				do: [ :def | 
					aStream nextPutAll: '    '.
					def
						printOn: aStream
						ifIncludedIn: aCollectionOfRMDSyntaxNode
						addSectionTo: aCollection ]
				separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
