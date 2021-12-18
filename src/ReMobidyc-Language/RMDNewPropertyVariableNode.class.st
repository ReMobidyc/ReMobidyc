Class {
	#name : #RMDNewPropertyVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNewPropertyVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #accessing }
RMDNewPropertyVariableNode >> agent [

	^ 'new'
]

{ #category : #enumerating }
RMDNewPropertyVariableNode >> childrenDo: aBlock [

	
]

{ #category : #testing }
RMDNewPropertyVariableNode >> isNewPropertyVariableNode [
	^ true
]

{ #category : #accessing }
RMDNewPropertyVariableNode >> precedence [
	^ 1
]

{ #category : #accessing }
RMDNewPropertyVariableNode >> prefix [

	^ 'new'
]

{ #category : #printing }
RMDNewPropertyVariableNode >> printOn: aStream [

	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier
]

{ #category : #printing }
RMDNewPropertyVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
