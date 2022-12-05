Class {
	#name : #RMDAttributeInitializerNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAttributeInitializerNode class >> identifier: aString expression: aRMDExpressionNode [
	^ self new
		identifier: aString;
		expression: aRMDExpressionNode;
		yourself
]

{ #category : #comparing }
RMDAttributeInitializerNode >> = anObject [
	^ self class = anObject class
		and: [ identifier = anObject identifier
				and: [ expression = anObject expression ] ]
]

{ #category : #enumerating }
RMDAttributeInitializerNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDAttributeInitializerNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDAttributeInitializerNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDAttributeInitializerNode >> hash [
	^ identifier hash bitXor: expression hash
]

{ #category : #accessing }
RMDAttributeInitializerNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDAttributeInitializerNode >> identifier: aString [
	identifier := aString
]

{ #category : #printing }
RMDAttributeInitializerNode >> isAttributeInitializerNode [
	^ true
]

{ #category : #copying }
RMDAttributeInitializerNode >> postCopy [

	expression := expression ifNotNil: #copy
]

{ #category : #printing }
RMDAttributeInitializerNode >> printOn: aStream [

	aStream nextPutAll: identifier.
	expression ifNotNil: [ 
		aStream nextPutAll: ' = '.
		expression printOn: aStream ]
]

{ #category : #printing }
RMDAttributeInitializerNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: identifier.
	expression ifNotNil: [ 
		aStream nextPutAll: ' = '.
		expression
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAttributeInitializerNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ].
	expression ifNotNil: [ 
		expression := expression copyReplace: aDictionary ]
]
