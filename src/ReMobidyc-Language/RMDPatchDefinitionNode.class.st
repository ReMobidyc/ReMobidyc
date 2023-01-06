Class {
	#name : #RMDPatchDefinitionNode,
	#superclass : #RMDAgentDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDPatchDefinitionNode class >> createBuiltinAttributes [

	^ {  }
]

{ #category : #'typical instances' }
RMDPatchDefinitionNode class >> grassField [
	<script: 'RMDPatchDefinitionNode grassField inspect'>
	^ RMDGrammar new patchDefinition end parse: 'Patch with
	grass [kcal].'
]

{ #category : #'typical instances' }
RMDPatchDefinitionNode class >> sugarField [
	<script: 'RMDPatchDefinitionNode sugarField inspect'>
	^ RMDGrammar new patchDefinition end parse: 'Patch with
	sugar [kcal].'
]

{ #category : #testing }
RMDPatchDefinitionNode >> isPatchDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPatchDefinitionNode >> name [

	^ 'Patch'
]

{ #category : #printing }
RMDPatchDefinitionNode >> printOn: aStream [

	aStream nextPutAll: 'Patch'.
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

{ #category : #printing }
RMDPatchDefinitionNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'Patch'.
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
