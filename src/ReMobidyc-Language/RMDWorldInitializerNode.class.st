Class {
	#name : #RMDWorldInitializerNode,
	#superclass : #RMDAgentInitializerNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> attributeInitializers: anArrayOfRMDAttributeInitializer [
	^ self new
		attributeInitializers: anArrayOfRMDAttributeInitializer;
		yourself
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> empty [
	<script: 'RMDWorldInitializerNode empty inspect'>
	^ self attributeInitializers: Array new
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> withTemperature [
	<script:
		'(RMDWorldInitializerNode attributeInitializers: {RMDAttributeInitializerNode identifier: ''temperature'' expression: ''27 [C]'' asRMDExpression}) inspect'>
	^ self attributeInitializers: Array new
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
	aStream nextPut: $,.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
