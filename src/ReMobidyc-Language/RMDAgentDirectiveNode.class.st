Class {
	#name : #RMDAgentDirectiveNode,
	#superclass : #RMDDirectiveNode,
	#instVars : [
		'agentIdentifier'
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

{ #category : #enumerating }
RMDAgentDirectiveNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDAgentDirectiveNode >> hash [
	^ super hash bitXor: agentIdentifier hash
]

{ #category : #testing }
RMDAgentDirectiveNode >> isAgentDirectiveNode [
	^ true
]

{ #category : #copying }
RMDAgentDirectiveNode >> postCopy [
	
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
	super replaceChildren: aDictionary.
	aDictionary
		at: agentIdentifier
		ifPresent: [ :node | agentIdentifier := node copy ]
]
