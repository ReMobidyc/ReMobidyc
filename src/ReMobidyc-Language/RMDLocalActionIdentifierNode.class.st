Class {
	#name : #RMDLocalActionIdentifierNode,
	#superclass : #RMDActionIdentifierNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDLocalActionIdentifierNode class >> identifier: aString [
	^ self new
		shortName: aString;
		yourself
]

{ #category : #testing }
RMDLocalActionIdentifierNode >> isLocalActionIdentifierNode [
	^ true
]

{ #category : #testing }
RMDLocalActionIdentifierNode >> isReadOnly [
	^ false
]

{ #category : #printing }
RMDLocalActionIdentifierNode >> printOn: aStream [
	aStream
		nextPutAll: shortName;
		nextPutAll: '@model'
]

{ #category : #printing }
RMDLocalActionIdentifierNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: shortName;
		nextPutAll: '@model'.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
