Class {
	#name : #RMDRightAssociativeApplicationNode,
	#superclass : #RMDBinaryOperatorApplicationNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #accessing }
RMDRightAssociativeApplicationNode >> printOn: aStream [
	self precedence <= expression1 first precedence
		ifTrue: [ aStream nextPut: $( ].
	expression1 first printOn: aStream.
	self precedence <= expression1 first precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: self operator.
	self precedence < expression2 precedence
		ifTrue: [ aStream nextPut: $( ].
	expression2 printOn: aStream.
	self precedence < expression2 precedence
		ifTrue: [ aStream nextPut: $) ]
]
