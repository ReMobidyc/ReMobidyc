Class {
	#name : #RMDWorldInitializerNode,
	#superclass : #RMDAgentInitializerNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> attributeInitializers: anArrayOfRMDAttributeInitializer utilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	^ self new
		  attributeInitializers: anArrayOfRMDAttributeInitializer;
		  utilityDefinitions: anArrayOfRMDUtilityDefinitionNode;
		  yourself
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> empty [

	<script: 'RMDWorldInitializerNode empty inspect'>
	^ self attributeInitializers: Array new utilityDefinitions: Array new
]

{ #category : #testing }
RMDWorldInitializerNode >> isWorldInitializerNode [
	^ true
]

{ #category : #printing }
RMDWorldInitializerNode >> printOn: aStream [

	aStream nextPutAll: 'World'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers
			do: [ :init | 
				aStream nextPutAll: '    '.
				init printOn: aStream ]
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
			separatedBy: [ aStream nextPut: Character cr ] ]
]

{ #category : #printing }
RMDWorldInitializerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'World'.
	attributeInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		attributeInitializers do: [ :init | 
			aStream nextPutAll: '    '.
			init
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ] ].
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
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
