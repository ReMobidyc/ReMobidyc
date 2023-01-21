Class {
	#name : #RMDAttributeVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#instVars : [
		'offset'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAttributeVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #'instance creation' }
RMDAttributeVariableNode class >> identifier: aString agent: anotherString [

	(anotherString isNil or: [ anotherString = #my ]) ifTrue: [ 
		^ RMDMyAttributeVariableNode identifier: aString ].
	anotherString = #here ifTrue: [ 
		^ RMDHereAttributeVariableNode identifier: aString ].
	anotherString = #world ifTrue: [ 
		^ RMDWorldAttributeVariableNode identifier: aString ].
	anotherString = #new ifTrue: [ 
		^ RMDNewAttributeVariableNode identifier: aString ].

	anotherString = #the ifTrue: [ 
		^ RMDPlaceholderNode new
			  identifier: aString;
			  yourself ].
	^ RMDObjectAttributeVariableNode
		  identifier: aString
		  agent: anotherString
]

{ #category : #accessing }
RMDAttributeVariableNode >> agent [

	^ self subclassResponsibility
]

{ #category : #enumerating }
RMDAttributeVariableNode >> childrenDo: aBlock [

]

{ #category : #testing }
RMDAttributeVariableNode >> isAttributeVariableNode [
	^ true
]

{ #category : #accessing }
RMDAttributeVariableNode >> offset [

	^ offset
]

{ #category : #accessing }
RMDAttributeVariableNode >> offset: anInteger [

	offset := anInteger
]

{ #category : #copying }
RMDAttributeVariableNode >> postCopy [

	super postCopy.
	offset := nil
]

{ #category : #accessing }
RMDAttributeVariableNode >> precedence [
	^ 1
]

{ #category : #accessing }
RMDAttributeVariableNode >> prefix [

	^ self subclassResponsibility
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
