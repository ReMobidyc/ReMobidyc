Class {
	#name : #RMDWorldInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'propertyInitializers'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> propertyInitializers: anArrayOfRMDPropertyInitializer [
	^ self new
		propertyInitializers: anArrayOfRMDPropertyInitializer;
		yourself
]

{ #category : #enumerating }
RMDWorldInitializerNode >> childrenDo: aBlock [
	propertyInitializers do: aBlock
]

{ #category : #printing }
RMDWorldInitializerNode >> printOn: aStream [
	aStream nextPutAll: 'World'.
	propertyInitializers
		ifNotEmpty: [ aStream
				nextPutAll: ' with';
				nextPut: Character cr.
			propertyInitializers do: [ :init | init printOn: aStream ] ].
	aStream nextPut: $,
]

{ #category : #accessing }
RMDWorldInitializerNode >> propertyInitializers [
	^ propertyInitializers
]

{ #category : #accessing }
RMDWorldInitializerNode >> propertyInitializers: anArrayOfRMDSimulationPropertyInitializerNode [
	propertyInitializers := anArrayOfRMDSimulationPropertyInitializerNode
]
