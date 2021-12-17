Class {
	#name : #RMDPropertyBindNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'placeholder',
		'replacement'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPropertyBindNode class >> placeholder: aRMDPlaceholderNode replacement: aRMDSyntaxNode [

	^ self new
		  placeholder: aRMDPlaceholderNode;
		  replacement: aRMDSyntaxNode;
		  yourself
]

{ #category : #comparing }
RMDPropertyBindNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholder = anObject placeholder and: [ 
			  replacement = anObject replacement ] ]
]

{ #category : #enumerating }
RMDPropertyBindNode >> childrenDo: aBlock [
	
]

{ #category : #comparing }
RMDPropertyBindNode >> hash [

	^ (self class hash bitXor: placeholder hash) bitXor: replacement hash
]

{ #category : #testing }
RMDPropertyBindNode >> isPropertyBindNode [
	^ true
]

{ #category : #accessing }
RMDPropertyBindNode >> placeholder [

	^ placeholder
]

{ #category : #accessing }
RMDPropertyBindNode >> placeholder: aRMDSyntaxNode [

	placeholder := aRMDSyntaxNode
]

{ #category : #copying }
RMDPropertyBindNode >> postCopy [
	
]

{ #category : #printing }
RMDPropertyBindNode >> printOn: aStream [

	placeholder printOn: aStream.
	aStream nextPutAll: ' -> '.
	replacement printOn: aStream
]

{ #category : #printing }
RMDPropertyBindNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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
RMDPropertyBindNode >> replaceChildren: aDictionary [

	placeholder := placeholder copyReplace: aDictionary.
	replacement := replacement copyReplace: aDictionary
]

{ #category : #accessing }
RMDPropertyBindNode >> replacement [
	^ replacement
]

{ #category : #accessing }
RMDPropertyBindNode >> replacement: aRMDSyntaxNode [

	replacement := aRMDSyntaxNode
]
