Class {
	#name : #RMDAttributeVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'agent'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAttributeVariableNode class >> identifier: aString agent: anotherString [

	anotherString = #my ifTrue: [ ^ self identifier: aString agent: nil ].
	anotherString = #new ifTrue: [ 
		^ RMDNewAttributeVariableNode identifier: aString ].

	anotherString = #the ifTrue: [ 
		^ RMDPlaceholderNode new
			  identifier: aString;
			  yourself ].
	^ self new
		  identifier: aString;
		  agent: anotherString;
		  yourself
]

{ #category : #comparing }
RMDAttributeVariableNode >> = anObject [
	^ super = anObject and: [ agent = anObject agent ]
]

{ #category : #accessing }
RMDAttributeVariableNode >> agent [
	^ agent
]

{ #category : #accessing }
RMDAttributeVariableNode >> agent: aString [
	agent := aString
]

{ #category : #enumerating }
RMDAttributeVariableNode >> childrenDo: aBlock [

]

{ #category : #comparing }
RMDAttributeVariableNode >> hash [
	^ super hash bitXor: agent hash
]

{ #category : #testing }
RMDAttributeVariableNode >> isAttributeVariableNode [
	^ true
]

{ #category : #accessing }
RMDAttributeVariableNode >> precedence [
	^ 1
]

{ #category : #accessing }
RMDAttributeVariableNode >> prefix [

	^ agent ifNil: [ 'my' ] ifNotNil: [ agent , '''s ' ]
]

{ #category : #printing }
RMDAttributeVariableNode >> printOn: aStream [

	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier
]

{ #category : #printing }
RMDAttributeVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAttributeVariableNode >> renameAnimat: aString to: anotherString [

	agent = aString uncapitalized ifTrue: [ 
		agent := anotherString uncapitalized ].
	super renameAnimat: aString to: anotherString
]

{ #category : #rewriting }
RMDAttributeVariableNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: agent ifPresent: [ :node | agent := node copy ]
]
