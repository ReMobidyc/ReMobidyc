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
