Class {
	#name : #RMDPropertyVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'agent'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDPropertyVariableNode >> = anObject [
	^ self class = anObject class and: [ agent = anObject agent ]
]

{ #category : #accessing }
RMDPropertyVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDPropertyVariableNode >> agent: aString [
	agent := aString
]

{ #category : #comparing }
RMDPropertyVariableNode >> hash [
	^ self class hash bitXor: agent hash
]

{ #category : #accessing }
RMDPropertyVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDPropertyVariableNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDPropertyVariableNode >> printOn: aStream [
	agent
		ifNotNil: [ aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: identifier
]
