Class {
	#name : #RMDModelFileNode,
	#superclass : #RMDSyntaxNode,
	#category : #'ReMobidyc-Language-File'
}

{ #category : #comparing }
RMDModelFileNode >> = anObject [

	^ self == anObject
]

{ #category : #enumerating }
RMDModelFileNode >> childrenDo: aBlock [

	
]

{ #category : #enumerating }
RMDModelFileNode >> childrenTransform: aBlock [

	
]

{ #category : #enumerating }
RMDModelFileNode >> contentsDo: aBlock [

	^ self subclassResponsibility
]

{ #category : #comparing }
RMDModelFileNode >> hash [

	^ self identityHash
]

{ #category : #copying }
RMDModelFileNode >> postCopy [

	
]

{ #category : #printing }
RMDModelFileNode >> printOn: aStream [

	self contentsDo: [ :content | content printOn: aStream ]
]

{ #category : #printing }
RMDModelFileNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	self contentsDo: [ :content | 
		content
			printOn: aStream
			ifIncludedIn: aCollectionOfRMDSyntaxNode
			addSectionTo: aCollection ]
]

{ #category : #rewriting }
RMDModelFileNode >> replaceChildren: aDictionary [

	
]
