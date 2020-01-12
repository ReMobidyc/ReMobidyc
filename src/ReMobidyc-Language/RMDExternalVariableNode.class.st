Class {
	#name : #RMDExternalVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'agent111'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDExternalVariableNode class >> agent: aRMDAgentNode identifier: aString [
	^ self new
		agent: aRMDAgentNode;
		identifier: aString;
		yourself
]

{ #category : #comparing }
RMDExternalVariableNode >> = anObject [
	^ super = anObject and: [ agent111 = anObject agent ]
]

{ #category : #accessing }
RMDExternalVariableNode >> agent [
	^ agent111
]

{ #category : #accessing }
RMDExternalVariableNode >> agent: aRMDAgentReferenceNode [
	agent111 := aRMDAgentReferenceNode
]

{ #category : #comparing }
RMDExternalVariableNode >> hash [
	^ super hash bitXor: agent111 hash
]

{ #category : #testing }
RMDExternalVariableNode >> isExternalVariableNode [
	^ true
]

{ #category : #accessing }
RMDExternalVariableNode >> operator [
	^ '''s'
]

{ #category : #accessing }
RMDExternalVariableNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDExternalVariableNode >> printOn: aStream [
	agent111 printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space;
		nextPutAll: identifier
]
