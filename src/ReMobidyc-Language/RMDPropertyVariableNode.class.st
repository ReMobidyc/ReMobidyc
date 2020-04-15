Class {
	#name : #RMDPropertyVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'agent'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		identifier: aString;
		agent: anotherString;
		yourself
]

{ #category : #comparing }
RMDPropertyVariableNode >> = anObject [
	^ super = anObject and: [ agent = anObject agent ]
]

{ #category : #accessing }
RMDPropertyVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDPropertyVariableNode >> agent: aString [
	agent := aString
]

{ #category : #enumerating }
RMDPropertyVariableNode >> childrenDo: aBlock [

]

{ #category : #comparing }
RMDPropertyVariableNode >> hash [
	^ super hash bitXor: agent hash
]

{ #category : #testing }
RMDPropertyVariableNode >> isPropertyVariableNode [
	^ true
]

{ #category : #accessing }
RMDPropertyVariableNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDPropertyVariableNode >> printOn: aStream [
	agent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: identifier
]

{ #category : #rewriting }
RMDPropertyVariableNode >> replaceChildren: aDictionary [

]
