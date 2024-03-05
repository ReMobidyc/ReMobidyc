Class {
	#name : #RMDParameterInstantiationNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'placeholder',
		'replacement'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDParameterInstantiationNode class >> placeholder: aRMDPlaceholderNode replacement: aRMDSyntaxNode [

	^ self new
		  placeholder: aRMDPlaceholderNode;
		  replacement: aRMDSyntaxNode;
		  yourself
]

{ #category : #comparing }
RMDParameterInstantiationNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholder = anObject placeholder and: [ 
			  replacement = anObject replacement ] ]
]

{ #category : #enumerating }
RMDParameterInstantiationNode >> childrenDo: aBlock [

	placeholder ifNotNil: [ aBlock value: placeholder ].
	replacement ifNotNil: [ aBlock value: replacement ]
]

{ #category : #enumerating }
RMDParameterInstantiationNode >> childrenTransform: aBlock [

	placeholder ifNotNil: [ placeholder := aBlock value: placeholder ].
	replacement ifNotNil: [ replacement := aBlock value: replacement ]
]

{ #category : #comparing }
RMDParameterInstantiationNode >> hash [

	^ (self class hash bitXor: placeholder hash) bitXor: replacement hash
]

{ #category : #testing }
RMDParameterInstantiationNode >> isParameterInstantiationNode [
	^ true
]

{ #category : #rewriting }
RMDParameterInstantiationNode >> metaparameters: aDictionary [

	^ self copy
		  replacement: (replacement copyReplace: aDictionary);
		  yourself
]

{ #category : #accessing }
RMDParameterInstantiationNode >> placeholder [

	^ placeholder
]

{ #category : #accessing }
RMDParameterInstantiationNode >> placeholder: aRMDSyntaxNode [

	placeholder := aRMDSyntaxNode
]

{ #category : #copying }
RMDParameterInstantiationNode >> postCopy [
	
]

{ #category : #printing }
RMDParameterInstantiationNode >> printOn: aStream [

	placeholder printOn: aStream.
	aStream nextPutAll: ' -> '.
	replacement printOn: aStream
]

{ #category : #printing }
RMDParameterInstantiationNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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
RMDParameterInstantiationNode >> replaceChildren: aDictionary [

	placeholder := placeholder copyReplace: aDictionary.
	replacement := replacement copyReplace: aDictionary
]

{ #category : #accessing }
RMDParameterInstantiationNode >> replacement [
	^ replacement
]

{ #category : #accessing }
RMDParameterInstantiationNode >> replacement: aRMDSyntaxNode [

	replacement := aRMDSyntaxNode
]
