Class {
	#name : #RMDAgentDirectiveNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'agentIdentifier',
		'directive'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAgentDirectiveNode class >> directive: aString agent: anotherString [
	^ self new
		directive: aString;
		agentIdentifier: anotherString;
		yourself
]

{ #category : #accessing }
RMDAgentDirectiveNode >> agentIdentifier [
	^ agentIdentifier
]

{ #category : #accessing }
RMDAgentDirectiveNode >> agentIdentifier: aString [
	agentIdentifier := aString
]

{ #category : #accessing }
RMDAgentDirectiveNode >> directive [
	^ directive
]

{ #category : #accessing }
RMDAgentDirectiveNode >> directive: aString [
	directive := aString
]

{ #category : #testing }
RMDAgentDirectiveNode >> isAgentDirectiveNode [
	^ true
]

{ #category : #accessing }
RMDAgentDirectiveNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDAgentDirectiveNode >> printOn: aStream [
	aStream
		nextPutAll: directive;
		nextPut: Character space;
		nextPutAll: agentIdentifier
]
