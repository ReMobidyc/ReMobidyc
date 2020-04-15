Class {
	#name : #RMDAssignablePropertyVariableNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'agent',
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAssignablePropertyVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		identifier: aString;
		agent: anotherString;
		yourself
]

{ #category : #comparing }
RMDAssignablePropertyVariableNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier and: [ agent = anObject agent ] ]
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> agent: aString [
	agent := aString
]

{ #category : #enumerating }
RMDAssignablePropertyVariableNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDAssignablePropertyVariableNode >> hash [
	^ (self class hash bitXor: identifier hash) bitXor: agent hash
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDAssignablePropertyVariableNode >> printOn: aStream [
	agent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: identifier
]
