Class {
	#name : #RMDAbstractVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'agent',
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAbstractVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #'instance creation' }
RMDAbstractVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		identifier: aString;
		agent: anotherString;
		yourself
]

{ #category : #comparing }
RMDAbstractVariableNode >> = anObject [
	^ self class = anObject class and: [ identifier = anObject identifier ]
]

{ #category : #accessing }
RMDAbstractVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDAbstractVariableNode >> agent: aString [
	agent := aString
]

{ #category : #comparing }
RMDAbstractVariableNode >> hash [
	^ self class hash bitXor: identifier hash
]

{ #category : #accessing }
RMDAbstractVariableNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAbstractVariableNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDAbstractVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
RMDAbstractVariableNode >> printOn: aStream [
	agent
		ifNotNil: [ aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: identifier
]
