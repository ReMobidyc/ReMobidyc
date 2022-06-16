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
	directive = 'delta time'
		ifTrue: [ aStream nextPutAll: 'Δtime'.
			^ self ].
	directive = 'directionOfGradient'
		ifTrue: [ aStream
				nextPutAll: 'direction grad ';
				nextPutAll: agentIdentifier.
			^ self ].
	aStream nextPutAll: directive.
	agentIdentifier
		ifNotNil: [ aStream
				nextPut: Character space;
				nextPutAll: agentIdentifier ]
]

{ #category : #printing }
RMDAgentDirectiveNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	directive = 'delta time'
		ifTrue: [ aStream nextPutAll: 'Δtime'.
			^ self ].
	directive = 'directionOfGradient'
		ifTrue: [ aStream
				nextPutAll: 'direction grad ';
				nextPutAll: agentIdentifier.
			^ self ].
	aStream nextPutAll: directive.
	agentIdentifier
		ifNotNil: [ aStream
				nextPut: Character space;
				nextPutAll: agentIdentifier ].
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAgentDirectiveNode >> renameAnimat: aString to: anotherString [

	agentIdentifier = aString ifTrue: [ agentIdentifier := anotherString ].
	super renameAnimat: aString to: anotherString
]

{ #category : #rewriting }
RMDAgentDirectiveNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary
		at: agentIdentifier
		ifPresent: [ :node | agentIdentifier := node copy ]
]
