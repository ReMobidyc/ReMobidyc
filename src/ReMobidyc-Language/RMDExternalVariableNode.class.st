Class {
	#name : #RMDExternalVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'agent'
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
	^ super = anObject and: [ agent = anObject agent ]
]

{ #category : #accessing }
RMDExternalVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDExternalVariableNode >> agent: aRMDAgentReferenceNode [
	agent := aRMDAgentReferenceNode
]

{ #category : #comparing }
RMDExternalVariableNode >> hash [
	^ super hash bitXor: agent hash
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
	agent printOn: aStream.
	aStream
		nextPut: Character space;
		nextPutAll: self operator;
		nextPut: Character space;
		nextPutAll: identifier
]
