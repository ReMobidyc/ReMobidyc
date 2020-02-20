Class {
	#name : #RMDWorldInitializerNode,
	#superclass : #RMDSpeciesInitializerNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> default [
	^ self propertyInitializers: Array new
]

{ #category : #'instance creation' }
RMDWorldInitializerNode class >> propertyInitializers: anArrayOfRMDPropertyInitializer [
	^ self new
		propertyInitializers: anArrayOfRMDPropertyInitializer;
		yourself
]

{ #category : #testing }
RMDWorldInitializerNode >> isWorldInitializerNode [
	^ true
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
