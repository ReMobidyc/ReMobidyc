Class {
	#name : #RMDWorldDefinitionNode,
	#superclass : #RMDSpeciesDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDWorldDefinitionNode class >> createBuiltinProperties [
	^ {}
]

{ #category : #'typical instances' }
RMDWorldDefinitionNode class >> empty [
	<script: 'RMDWorldDefinitionNode empty inspect'>
	^ self propertyDeclarations: {}
]

{ #category : #testing }
RMDWorldDefinitionNode >> isWorldDefinitionNode [
	^ true
]

{ #category : #printing }
RMDWorldDefinitionNode >> printOn: aStream [
	aStream nextPutAll: 'World'.
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
