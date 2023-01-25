Class {
	#name : #RMDParameterSequenceNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'placeholder',
		'literals'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDParameterSequenceNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholder = anObject placeholder and: [ 
			  literals = anObject literals ] ]
]

{ #category : #enumerating }
RMDParameterSequenceNode >> childrenDo: aBlock [

	aBlock value: placeholder.
	literals do: aBlock
]

{ #category : #comparing }
RMDParameterSequenceNode >> hash [

	^ (self class hash bitXor: placeholder hash) bitXor: literals hash
]

{ #category : #accessing }
RMDParameterSequenceNode >> literalAt: anInteger ifAbsent: errorBlock [

	^ literals at: anInteger ifAbsent: errorBlock
]

{ #category : #accessing }
RMDParameterSequenceNode >> literals [

	^ literals
]

{ #category : #accessing }
RMDParameterSequenceNode >> literals: anArrayOfRMDLiteralNode [

	literals := anArrayOfRMDLiteralNode
]

{ #category : #accessing }
RMDParameterSequenceNode >> placeholder [

	^ placeholder
]

{ #category : #accessing }
RMDParameterSequenceNode >> placeholder: anArrayOfRMDPlaceholderNode [

	placeholder := anArrayOfRMDPlaceholderNode
]

{ #category : #copying }
RMDParameterSequenceNode >> postCopy [

	super postCopy.
	placeholder := placeholder copy.
	literals := literals collect: #copy
]

{ #category : #printing }
RMDParameterSequenceNode >> printOn: aStream [

	placeholder printOn: aStream.
	aStream nextPutAll: ' -> '.
	literals
		do: [ :literal | literal printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #printing }
RMDParameterSequenceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	placeholder
		printOn: aStream
		ifIncludedIn: aCollectionOfRMDSyntaxNode
		addSectionTo: aCollection.
	aStream nextPutAll: ' -> '.
	literals
		do: [ :literal | 
			literal
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDParameterSequenceNode >> replaceChildren: aDictionary [

	placeholder := placeholder copyReplace: aDictionary.
	literals := literals collect: [ :literal | 
		            literal copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDParameterSequenceNode >> sequenceSize [

	^ literals size
]
