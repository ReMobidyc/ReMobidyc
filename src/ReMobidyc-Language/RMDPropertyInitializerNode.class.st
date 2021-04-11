Class {
	#name : #RMDPropertyInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyInitializerNode class >> identifier: aString expression: aRMDExpressionNode [
	^ self new
		identifier: aString;
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #comparing }
RMDPropertyInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ expression = anObject expression ] ]
]

{ #category : #enumerating }
RMDPropertyInitializerNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDPropertyInitializerNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPropertyInitializerNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDPropertyInitializerNode >> hash [
	^ identifier hash bitXor: expression hash
]

{ #category : #accessing }
RMDPropertyInitializerNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDPropertyInitializerNode >> identifier: aString [
	identifier := aString
]

{ #category : #'type checking' }
RMDPropertyInitializerNode >> inferType [
	self unifyType: expression inferType.
	^ type
]

{ #category : #printing }
RMDPropertyInitializerNode >> isPropertyInitializerNode [
	^ true
]

{ #category : #copying }
RMDPropertyInitializerNode >> postCopy [
	expression := expression copy
]

{ #category : #printing }
RMDPropertyInitializerNode >> printOn: aStream [
	aStream
		nextPutAll: identifier;
		nextPutAll: ' = '.
	expression printOn: aStream
]

{ #category : #rewriting }
RMDPropertyInitializerNode >> replaceChildren: aDictionary [
	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	expression := expression copyReplace: aDictionary
]
