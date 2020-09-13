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
