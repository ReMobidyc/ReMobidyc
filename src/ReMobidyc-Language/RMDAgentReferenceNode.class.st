Class {
	#name : #RMDAgentReferenceNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAgentReferenceNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #comparing }
RMDAgentReferenceNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier ]
]

{ #category : #comparing }
RMDAgentReferenceNode >> hash [
	^ self class hash bitXor: identifier hash
]

{ #category : #accessing }
RMDAgentReferenceNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAgentReferenceNode >> identifier: aString [
	identifier := aString
]

{ #category : #testing }
RMDAgentReferenceNode >> isAgentReferenceNode [
	^ true
]

{ #category : #printing }
RMDAgentReferenceNode >> printOn: aStream [
	aStream nextPutAll: identifier
]
