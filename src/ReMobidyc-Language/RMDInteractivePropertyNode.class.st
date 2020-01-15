Class {
	#name : #RMDInteractivePropertyNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'identifier',
		'agentIdentifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDInteractivePropertyNode class >> directive: aString agent: anotherString [
	^ self new
		identifier: aString;
		agentIdentifier: anotherString;
		yourself
]

{ #category : #accessing }
RMDInteractivePropertyNode >> agentIdentifier [
	^ agentIdentifier
]

{ #category : #accessing }
RMDInteractivePropertyNode >> agentIdentifier: aString [
	agentIdentifier := aString
]

{ #category : #accessing }
RMDInteractivePropertyNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDInteractivePropertyNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #accessing }
RMDInteractivePropertyNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDInteractivePropertyNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPut: Character space;
		nextPutAll: agentIdentifier
]
