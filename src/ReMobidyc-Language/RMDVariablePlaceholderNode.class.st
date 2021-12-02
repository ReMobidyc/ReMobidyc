Class {
	#name : #RMDVariablePlaceholderNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDVariablePlaceholderNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #enumerating }
RMDVariablePlaceholderNode >> childrenDo: aBlock [

	
]

{ #category : #testing }
RMDVariablePlaceholderNode >> isVariablePlaceholderNode [
	^ true
]

{ #category : #accessing }
RMDVariablePlaceholderNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDVariablePlaceholderNode >> printOn: aStream [

	aStream
		nextPutAll: 'the ';
		nextPutAll: identifier
]

{ #category : #printing }
RMDVariablePlaceholderNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: 'the ';
		nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
