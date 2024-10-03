Class {
	#name : 'RMDMetaSingleParameterSequenceNode',
	#superclass : 'RMDMetaParameterSequenceNode',
	#instVars : [
		'placeholder',
		'literals'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDMetaSingleParameterSequenceNode class >> placeholder: aRMDPlaceholderNode literals: anArrayOfRMDLiteral [

	^ self new
		  placeholder: aRMDPlaceholderNode;
		  literals: anArrayOfRMDLiteral;
		  yourself
]

{ #category : 'comparing' }
RMDMetaSingleParameterSequenceNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholder = anObject placeholder and: [ 
			  literals = anObject literals ] ]
]

{ #category : 'enumerating' }
RMDMetaSingleParameterSequenceNode >> childrenDo: aBlock [

	aBlock value: placeholder.
	literals do: aBlock
]

{ #category : 'enumerating' }
RMDMetaSingleParameterSequenceNode >> childrenTransform: aBlock [

	placeholder := aBlock value: placeholder.
	literals := literals collect: aBlock
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> dictionaryAt: anInteger ifAbsent: errorBlock [

	| literal |
	literal := literals at: anInteger ifAbsent: [ ^ errorBlock value ].
	^ Dictionary new
		  at: placeholder put: literal;
		  yourself
]

{ #category : 'comparing' }
RMDMetaSingleParameterSequenceNode >> hash [

	^ (self class hash bitXor: placeholder hash) bitXor: literals hash
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> literalAt: anInteger ifAbsent: errorBlock [

	^ literals at: anInteger ifAbsent: errorBlock
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> literals [

	^ literals
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> literals: anArrayOfRMDLiteralNode [

	literals := anArrayOfRMDLiteralNode
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> metaParametersSize [

	^ 1
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> placeholder [

	^ placeholder
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> placeholder: anArrayOfRMDPlaceholderNode [

	placeholder := anArrayOfRMDPlaceholderNode
]

{ #category : 'enumerating' }
RMDMetaSingleParameterSequenceNode >> placeholdersDo: aBlock [

	aBlock value: placeholder
]

{ #category : 'copying' }
RMDMetaSingleParameterSequenceNode >> postCopy [

	placeholder := placeholder copy.
	literals := literals collect: #copy
]

{ #category : 'printing' }
RMDMetaSingleParameterSequenceNode >> printOn: aStream [

	placeholder printOn: aStream.
	aStream nextPutAll: ' -> '.
	literals
		do: [ :literal | literal printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : 'printing' }
RMDMetaSingleParameterSequenceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

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

{ #category : 'rewriting' }
RMDMetaSingleParameterSequenceNode >> replaceChildren: aDictionary [

	placeholder := placeholder copyReplace: aDictionary.
	literals := literals collect: [ :literal | 
		            literal copyReplace: aDictionary ]
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequenceNode >> size [

	^ literals size
]

{ #category : 'operations' }
RMDMetaSingleParameterSequenceNode >> withoutPlaceholders: aCollectionOfRMDPlaceholderNode [

	^ (aCollectionOfRMDPlaceholderNode includes: placeholder)
		  ifTrue: [ nil ]
		  ifFalse: [ self ]
]
