Class {
	#name : #RMDAbstractAssignablePropertyVariableNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'propertyVariable'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAbstractAssignablePropertyVariableNode class >> identifier: aString agent: anotherString [
	^ self new
		propertyVariable: (RMDPropertyVariableNode identifier: aString agent: anotherString);
		yourself
]

{ #category : #'instance creation' }
RMDAbstractAssignablePropertyVariableNode class >> propertyVariable: aRMDPropertyVariableNode [

	^ self new
		  propertyVariable: aRMDPropertyVariableNode;
		  yourself
]

{ #category : #comparing }
RMDAbstractAssignablePropertyVariableNode >> = anObject [
	^ self class = anObject class
		and: [ propertyVariable = anObject propertyVariable ]
]

{ #category : #accessing }
RMDAbstractAssignablePropertyVariableNode >> agent [
	^ propertyVariable agent
]

{ #category : #enumerating }
RMDAbstractAssignablePropertyVariableNode >> childrenDo: aBlock [
	aBlock value: propertyVariable
]

{ #category : #comparing }
RMDAbstractAssignablePropertyVariableNode >> hash [
	^ self class hash bitXor: propertyVariable hash
]

{ #category : #accessing }
RMDAbstractAssignablePropertyVariableNode >> identifier [
	^ propertyVariable identifier
]

{ #category : #accessing }
RMDAbstractAssignablePropertyVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #copying }
RMDAbstractAssignablePropertyVariableNode >> postCopy [
	
]

{ #category : #printing }
RMDAbstractAssignablePropertyVariableNode >> printOn: aStream [
	self agent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ :agent | 
			aStream
				nextPutAll: agent;
				nextPutAll: '''s ' ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: self identifier
]

{ #category : #printing }
RMDAbstractAssignablePropertyVariableNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	propertyVariable isPlaceholderNode
		ifTrue: [ aStream nextPutAll: 'the ' ]
		ifFalse: [ 
			self agent
				ifNil: [ aStream nextPutAll: 'my ' ]
				ifNotNil: [ :agent | 
					aStream
						nextPutAll: agent;
						nextPutAll: '''s ' ] ].
	aStream nextPutAll: self operator.
	aStream nextPutAll: self identifier.
	((aCollectionOfRMDSyntaxNode includes: self) or: [ 
		 aCollectionOfRMDSyntaxNode includes: propertyVariable ]) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #accessing }
RMDAbstractAssignablePropertyVariableNode >> propertyVariable [
	^ propertyVariable
]

{ #category : #accessing }
RMDAbstractAssignablePropertyVariableNode >> propertyVariable: aRMDPropertyVariableNode [
	propertyVariable := aRMDPropertyVariableNode
]

{ #category : #rewriting }
RMDAbstractAssignablePropertyVariableNode >> replaceChildren: aDictionary [
	propertyVariable := propertyVariable copyReplace: aDictionary
]
