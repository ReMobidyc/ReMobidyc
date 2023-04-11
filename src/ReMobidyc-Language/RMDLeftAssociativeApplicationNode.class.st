Class {
	#name : #RMDLeftAssociativeApplicationNode,
	#superclass : #RMDBinaryOperatorApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDLeftAssociativeApplicationNode class >> isAbstract [

	^ self == RMDLeftAssociativeApplicationNode
]

{ #category : #printing }
RMDLeftAssociativeApplicationNode >> printOn: aStream [
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1 printOn: aStream.
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: self operator.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2 printOn: aStream.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $) ]
]

{ #category : #printing }
RMDLeftAssociativeApplicationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence < expression1 precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: self operator.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $) ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
