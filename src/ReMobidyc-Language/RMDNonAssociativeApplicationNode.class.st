Class {
	#name : #RMDNonAssociativeApplicationNode,
	#superclass : #RMDBinaryOperatorApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #printing }
RMDNonAssociativeApplicationNode >> printOn: aStream [
	self precedence <= expression1 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1 printOn: aStream.
	self precedence <= expression1 precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: self operator.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2 printOn: aStream.
	self precedence <= expression2 precedence
		ifTrue: [ aStream nextPut: $) ]
]
