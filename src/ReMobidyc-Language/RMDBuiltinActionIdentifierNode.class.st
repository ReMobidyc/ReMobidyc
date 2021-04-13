Class {
	#name : #RMDBuiltinActionIdentifierNode,
	#superclass : #RMDActionIdentifierNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDBuiltinActionIdentifierNode class >> identifier: aString [
	^ self new
		shortName: aString;
		yourself
]

{ #category : #testing }
RMDBuiltinActionIdentifierNode >> isBuiltinActionIdentifierNode [
	^ true
]

{ #category : #testing }
RMDBuiltinActionIdentifierNode >> isReadOnly [
	^ true
]

{ #category : #printing }
RMDBuiltinActionIdentifierNode >> printOn: aStream [
	aStream nextPutAll: shortName
]

{ #category : #printing }
RMDBuiltinActionIdentifierNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: shortName.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
