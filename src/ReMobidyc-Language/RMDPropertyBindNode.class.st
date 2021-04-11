Class {
	#name : #RMDPropertyBindNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'actionAgent',
		'actionProperty',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyBindNode class >> actionAgent: agentStringOrNil property: propertyString1 expression: aRMDExpressionNode [
	^ self new
		actionAgent: agentStringOrNil;
		actionProperty: propertyString1;
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #comparing }
RMDPropertyBindNode >> = anObject [
	^ self class = anObject class
		and: [ actionAgent = anObject actionAgent
				and: [ actionProperty = anObject actionProperty
						and: [ expression = anObject expression ] ] ]
]

{ #category : #accessing }
RMDPropertyBindNode >> actionAgent [
	^ actionAgent
]

{ #category : #accessing }
RMDPropertyBindNode >> actionAgent: aString [
	actionAgent := aString
]

{ #category : #accessing }
RMDPropertyBindNode >> actionProperty [
	^ actionProperty
]

{ #category : #accessing }
RMDPropertyBindNode >> actionProperty: aString [
	actionProperty := aString
]

{ #category : #enumerating }
RMDPropertyBindNode >> childrenDo: aBlock [
	
]

{ #category : #accessing }
RMDPropertyBindNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPropertyBindNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDPropertyBindNode >> hash [
	^ ((self class hash bitXor: actionAgent hash)
		bitXor: actionProperty hash) bitXor: expression hash
]

{ #category : #'type checking' }
RMDPropertyBindNode >> inferType [
	^ type
]

{ #category : #testing }
RMDPropertyBindNode >> isPropertyBindNode [
	^ true
]

{ #category : #copying }
RMDPropertyBindNode >> postCopy [
	
]

{ #category : #printing }
RMDPropertyBindNode >> printOn: aStream [
	actionAgent
		ifNil: [ aStream nextPutAll: 'my ' ]
		ifNotNil: [ aStream
				nextPutAll: actionAgent;
				nextPutAll: '''s ' ].
	aStream
		nextPutAll: actionProperty;
		nextPutAll: ' -> '.
	expression printOn: aStream
]

{ #category : #rewriting }
RMDPropertyBindNode >> replaceChildren: aDictionary [
	aDictionary
		at: actionAgent
		ifPresent: [ :node | actionAgent := node copy ].
	aDictionary
		at: actionProperty
		ifPresent: [ :node | actionProperty := node copy ].
	expression := expression copyReplace: aDictionary
]
