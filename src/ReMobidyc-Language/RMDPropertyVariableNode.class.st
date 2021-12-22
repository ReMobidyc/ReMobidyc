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

	anotherString = #my ifTrue: [ ^ self identifier: aString agent: nil ].
	anotherString = #new ifTrue: [ 
		^ RMDNewPropertyVariableNode identifier: aString ].

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

{ #category : #accessing }
RMDPropertyVariableNode >> prefix [

	^ agent ifNil: [ 'my' ] ifNotNil: [ agent , '''s ' ]
]

{ #category : #printing }
RMDPropertyVariableNode >> printOn: aStream [

	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier
]

{ #category : #printing }
RMDPropertyVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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
RMDPropertyVariableNode >> replaceChildren: aDictionary [
	super replaceChildren: aDictionary.
	aDictionary at: agent ifPresent: [ :node | agent := node copy ]
]
