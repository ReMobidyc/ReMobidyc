Class {
	#name : #RMDWorldInitializerNode,
	#superclass : #RMDSpeciesInitializerNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> empty [
	<script: 'RMDWorldInitializerNode empty inspect'>
	^ self propertyInitializers: Array new
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> propertyInitializers: anArrayOfRMDPropertyInitializer [
	^ self new
		propertyInitializers: anArrayOfRMDPropertyInitializer;
		yourself
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> withTemperature [
	<script:
		'(RMDWorldInitializerNode propertyInitializers: {RMDPropertyInitializerNode identifier: ''temperature'' expression: ''27 [C]'' asRMDExpression}) inspect'>
	^ self propertyInitializers: Array new
]

{ #category : #testing }
RMDWorldInitializerNode >> isWorldInitializerNode [
	^ true
]

{ #category : #printing }
RMDWorldInitializerNode >> printOn: aStream [

	aStream nextPutAll: 'World'.
	propertyInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		propertyInitializers
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
	propertyInitializers ifNotEmpty: [ 
		aStream
			nextPutAll: ' with';
			nextPut: Character cr.
		propertyInitializers do: [ :init | 
			aStream nextPutAll: '    '.
			init
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ] ].
	aStream nextPut: $,.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
