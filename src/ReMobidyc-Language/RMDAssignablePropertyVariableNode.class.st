Class {
	#name : #RMDAssignablePropertyVariableNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'propertyVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAssignablePropertyVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		propertyVariable: (RMDPropertyVariableNode identifier: aString agent: anotherString);
		yourself
]

{ #category : #comparing }
RMDAssignablePropertyVariableNode >> = anObject [
	^ self class = anObject class
		and: [ propertyVariable = anObject propertyVariable ]
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> agent [
	^ propertyVariable agent
]

{ #category : #enumerating }
RMDAssignablePropertyVariableNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDAssignablePropertyVariableNode >> hash [
	^ self class hash bitXor: propertyVariable hash
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> identifier [
	^ propertyVariable identifier
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #copying }
RMDAssignablePropertyVariableNode >> postCopy [
	
]

{ #category : #printing }
RMDAssignablePropertyVariableNode >> printOn: aStream [
	self agent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ :agent | 
			aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: self identifier
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> propertyVariable [
	^ propertyVariable
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> propertyVariable: aRMDPropertyVariableNode [
	propertyVariable := aRMDPropertyVariableNode
]

{ #category : #rewriting }
RMDAssignablePropertyVariableNode >> replaceChildren: aDictionary [
	propertyVariable := propertyVariable copyReplace: aDictionary
]
