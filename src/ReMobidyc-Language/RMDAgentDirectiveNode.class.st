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

{ #category : #comparing }
RMDAgentDirectiveNode >> = anObject [
	^ self class = anObject class
		and: [ agentIdentifier = anObject agentIdentifier
				and: [ directive = anObject directive ] ]
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

{ #category : #comparing }
RMDAgentDirectiveNode >> hash [
	^ agentIdentifier hash bitXor: directive hash
]

{ #category : #testing }
RMDAgentDirectiveNode >> isAgentDirectiveNode [
	^ true
]

{ #category : #copying }
RMDAgentDirectiveNode >> postCopy [
	
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

{ #category : #rewriting }
RMDAgentDirectiveNode >> replaceChildren: aDictionary [
	aDictionary
		at: agentIdentifier
		ifPresent: [ :node | agentIdentifier := node copy ].
	aDictionary
		at: directive
		ifPresent: [ :node | directive := node copy ]
]
