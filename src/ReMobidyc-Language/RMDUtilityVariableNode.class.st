Class {
	#name : #RMDUtilityVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUtilityVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #enumerating }
RMDUtilityVariableNode >> childrenDo: aBlock [

]

{ #category : #enumerating }
RMDUtilityVariableNode >> childrenTransform: aBlock [

]

{ #category : #testing }
RMDUtilityVariableNode >> isUtilityVariableNode [
	^ true
]

{ #category : #accessing }
RMDUtilityVariableNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDUtilityVariableNode >> printOn: aStream [
	aStream nextPutAll: identifier
]

{ #category : #printing }
RMDUtilityVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [
	| start |
	start := aStream position + 1.
	aStream nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self)
		ifTrue: [ aCollection add: (start to: aStream position) ]
]
