Class {
	#name : #RMDExpressionPlaceholderNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDExpressionPlaceholderNode class >> identifier: aString [

	^ self new
		  identifier: aString;
		  yourself
]

{ #category : #comparing }
RMDExpressionPlaceholderNode >> = anObject [

	^ self class == anObject class and: [ 
		  identifier = anObject identifier ]
]

{ #category : #enumerating }
RMDExpressionPlaceholderNode >> childrenDo: aBlock [

	
]

{ #category : #comparing }
RMDExpressionPlaceholderNode >> hash [

	^ self class hash bitXor: identifier hash
]

{ #category : #accessing }
RMDExpressionPlaceholderNode >> identifier [

	^ identifier
]

{ #category : #accessing }
RMDExpressionPlaceholderNode >> identifier: aString [

	identifier := aString
]

{ #category : #testing }
RMDExpressionPlaceholderNode >> isExpressionPlaceholderNode [
	^ true
]

{ #category : #copying }
RMDExpressionPlaceholderNode >> postCopy [

	
]

{ #category : #accessing }
RMDExpressionPlaceholderNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDExpressionPlaceholderNode >> printOn: aStream [

	aStream
		nextPutAll: 'the ';
		nextPutAll: identifier
]

{ #category : #printing }
RMDExpressionPlaceholderNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'the '.
	aStream nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDExpressionPlaceholderNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]
