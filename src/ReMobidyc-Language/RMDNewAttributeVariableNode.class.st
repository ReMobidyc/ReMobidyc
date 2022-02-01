Class {
	#name : #RMDNewAttributeVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNewAttributeVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #accessing }
RMDNewAttributeVariableNode >> agent [

	^ #new
]

{ #category : #enumerating }
RMDNewAttributeVariableNode >> childrenDo: aBlock [

	
]

{ #category : #testing }
RMDNewAttributeVariableNode >> isNewAttributeVariableNode [
	^ true
]

{ #category : #accessing }
RMDNewAttributeVariableNode >> precedence [
	^ 1
]

{ #category : #accessing }
RMDNewAttributeVariableNode >> prefix [

	^ 'new'
]

{ #category : #printing }
RMDNewAttributeVariableNode >> printOn: aStream [

	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier
]

{ #category : #printing }
RMDNewAttributeVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream
		nextPutAll: self prefix;
		space;
		nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]
