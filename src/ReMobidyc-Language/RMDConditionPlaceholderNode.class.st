Class {
	#name : #RMDConditionPlaceholderNode,
	#superclass : #RMDConditionNode,
	#instVars : [
		'identifier'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDConditionPlaceholderNode class >> identifier: aString [

	^ self new
		  identifier: aString;
		  yourself
]

{ #category : #comparing }
RMDConditionPlaceholderNode >> = anObject [

	^ self class = anObject class and: [ 
		  identifier = anObject identifier ]
]

{ #category : #enumerating }
RMDConditionPlaceholderNode >> childrenDo: aBlock [

	
]

{ #category : #comparing }
RMDConditionPlaceholderNode >> hash [

	^ self class hash bitXor: identifier hash
]

{ #category : #accessing }
RMDConditionPlaceholderNode >> identifier [

	^ identifier
]

{ #category : #accessing }
RMDConditionPlaceholderNode >> identifier: aString [

	identifier := aString
]

{ #category : #testing }
RMDConditionPlaceholderNode >> isConditionPlaceholderNode [

	^ true
]

{ #category : #copying }
RMDConditionPlaceholderNode >> postCopy [

	
]

{ #category : #accessing }
RMDConditionPlaceholderNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDConditionPlaceholderNode >> printOn: aStream [

	aStream
		nextPutAll: 'the ';
		nextPutAll: identifier
]

{ #category : #printing }
RMDConditionPlaceholderNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'the '.
	aStream nextPutAll: identifier.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDConditionPlaceholderNode >> replaceChildren: aDictionary [

	aDictionary
		at: identifier
		ifPresent: [ :node | identifier := node copy ]
]
