Class {
	#name : 'RMDWorldDefinitionNode',
	#superclass : 'RMDAgentDefinitionNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDWorldDefinitionNode class >> createBuiltinAttributes [

	^ {  }
]

{ #category : 'typical instances' }
RMDWorldDefinitionNode class >> empty [

	<script: 'RMDWorldDefinitionNode empty inspect'>
	^ self attributeDeclarations: Array new utilityDefinitions: Array new
]

{ #category : 'accessing' }
RMDWorldDefinitionNode >> fullName [

	^ self name
]

{ #category : 'testing' }
RMDWorldDefinitionNode >> isWorldDefinitionNode [
	^ true
]

{ #category : 'accessing' }
RMDWorldDefinitionNode >> name [

	^ 'World'
]

{ #category : 'printing' }
RMDWorldDefinitionNode >> printOn: aStream [

	aStream nextPutAll: 'World'.
	attributeDeclarations ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeDeclarations
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def printOn: aStream ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $.
]

{ #category : 'printing' }
RMDWorldDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'World'.
	attributeDeclarations ifNotEmpty: [ 
		aStream
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
	utilityDefinitions ifNotEmpty: [ 
		aStream
			nextPut: Character cr;
			nextPutAll: 'where';
			nextPut: Character cr.
		utilityDefinitions
			do: [ :def | 
				aStream nextPutAll: '    '.
				def
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ]
			separatedBy: [ aStream nextPut: Character cr ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
