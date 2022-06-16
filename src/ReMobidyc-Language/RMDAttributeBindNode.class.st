Class {
	#name : #RMDAttributeBindNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'placeholder',
		'replacement'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDAttributeBindNode class >> placeholder: aRMDPlaceholderNode replacement: aRMDSyntaxNode [

	^ self new
		  placeholder: aRMDPlaceholderNode;
		  replacement: aRMDSyntaxNode;
		  yourself
]

{ #category : #comparing }
RMDAttributeBindNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholder = anObject placeholder and: [ 
			  replacement = anObject replacement ] ]
]

{ #category : #enumerating }
RMDAttributeBindNode >> childrenDo: aBlock [

	placeholder ifNotNil: [ aBlock value: placeholder ].
	replacement ifNotNil: [ aBlock value: replacement ]
]

{ #category : #comparing }
RMDAttributeBindNode >> hash [

	^ (self class hash bitXor: placeholder hash) bitXor: replacement hash
]

{ #category : #testing }
RMDAttributeBindNode >> isAttributeBindNode [
	^ true
]

{ #category : #accessing }
RMDAttributeBindNode >> placeholder [

	^ placeholder
]

{ #category : #accessing }
RMDAttributeBindNode >> placeholder: aRMDSyntaxNode [

	placeholder := aRMDSyntaxNode
]

{ #category : #copying }
RMDAttributeBindNode >> postCopy [
	
]

{ #category : #printing }
RMDAttributeBindNode >> printOn: aStream [

	placeholder printOn: aStream.
	aStream nextPutAll: ' -> '.
	replacement printOn: aStream
]

{ #category : #printing }
RMDAttributeBindNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	placeholder
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' -> '.
	replacement
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDAttributeBindNode >> replaceChildren: aDictionary [

	placeholder := placeholder copyReplace: aDictionary.
	replacement := replacement copyReplace: aDictionary
]

{ #category : #accessing }
RMDAttributeBindNode >> replacement [
	^ replacement
]

{ #category : #accessing }
RMDAttributeBindNode >> replacement: aRMDSyntaxNode [

	replacement := aRMDSyntaxNode
]
