Class {
	#name : #RMDParameterSetSequenceNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'parameterSequences'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #comparing }
RMDParameterSetSequenceNode >> = anObject [

	^ self class = anObject and: [ 
		  parameterSequences = anObject parameterSequences ]
]

{ #category : #enumerating }
RMDParameterSetSequenceNode >> childrenDo: aBlock [

	parameterSequences do: aBlock
]

{ #category : #comparing }
RMDParameterSetSequenceNode >> hash [

	^ self class hash bitXor: parameterSequences hash
]

{ #category : #accessing }
RMDParameterSetSequenceNode >> parameterSequences [

	^ parameterSequences
]

{ #category : #accessing }
RMDParameterSetSequenceNode >> parameterSequences: anArrayOfRMDParameterSequenceNode [

	parameterSequences := anArrayOfRMDParameterSequenceNode
]

{ #category : #copying }
RMDParameterSetSequenceNode >> postCopy [

	super postCopy.
	parameterSequences := parameterSequences collect: #copy
]

{ #category : #printing }
RMDParameterSetSequenceNode >> printOn: aStream [

	parameterSequences
		do: [ :param | param placeholder printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' -> '.
	(1 to: self sequenceSize)
		do: [ :index | 
			aStream nextPut: $(.
			parameterSequences
				do: [ :param | (param literalAt: index) printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPut: $) ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #printing }
RMDParameterSetSequenceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	parameterSequences
		do: [ :param | 
			param placeholder
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' -> '.
	(1 to: self sequenceSize)
		do: [ :index | 
			aStream nextPut: $(.
			parameterSequences
				do: [ :param | 
					(param literalAt: index)
						printOn: aStream
						ifIncludedIn: aCollectionOfRMDSyntaxNode
						addSectionTo: aCollection ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPut: $) ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #rewriting }
RMDParameterSetSequenceNode >> replaceChildren: aDictionary [

	parameterSequences := parameterSequences collect: [ :param | 
		                      param copyReplace: aDictionary ]
]

{ #category : #accessing }
RMDParameterSetSequenceNode >> sequenceSize [

	^ parameterSequences
		  ifNotEmpty: [ parameterSequences first sequenceSize ]
		  ifEmpty: [ 0 ]
]
