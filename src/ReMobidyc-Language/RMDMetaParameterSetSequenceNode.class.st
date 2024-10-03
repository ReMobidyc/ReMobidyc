Class {
	#name : 'RMDMetaParameterSetSequenceNode',
	#superclass : 'RMDMetaParameterSequenceNode',
	#instVars : [
		'placeholders',
		'literalTuples'
	],
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'instance creation' }
RMDMetaParameterSetSequenceNode class >> placeholders: anArrayOfRMDPlaceHolder literalTuples: anArrayOfArrayOfRMDLiteralNode [

	^ self new
		  placeholders: anArrayOfRMDPlaceHolder;
		  literalTuples: anArrayOfArrayOfRMDLiteralNode;
		  yourself
]

{ #category : 'comparing' }
RMDMetaParameterSetSequenceNode >> = anObject [

	^ self class = anObject class and: [ 
		  placeholders = anObject placeholders and: [ 
			  literalTuples = anObject literalTuples ] ]
]

{ #category : 'enumerating' }
RMDMetaParameterSetSequenceNode >> childrenDo: aBlock [

	placeholders do: aBlock.
	literalTuples do: [ :tuple | tuple do: aBlock ]
]

{ #category : 'enumerating' }
RMDMetaParameterSetSequenceNode >> childrenTransform: aBlock [

	placeholders := placeholders collect: aBlock.
	literalTuples := literalTuples collect: [ :tuple |
		                 tuple collect: aBlock ]
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> dictionaryAt: anInteger ifAbsent: errorBlock [

	| tuple dict |
	tuple := literalTuples at: anInteger ifAbsent: [ ^ errorBlock value ].
	dict := Dictionary new: placeholders size.
	1 to: placeholders size do: [ :index | 
	dict at: (placeholders at: index) put: (tuple at: index) ].
	^ dict
]

{ #category : 'comparing' }
RMDMetaParameterSetSequenceNode >> hash [

	^ (self class hash bitXor: placeholders hash) bitXor:
		  literalTuples hash
]

{ #category : 'testing' }
RMDMetaParameterSetSequenceNode >> isMetaParameterSetSequenceNode [

	^ true
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> literalTuples [

	^ literalTuples
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> literalTuples: anArrayOfArrayOfRMDLiteralNode [

	literalTuples := anArrayOfArrayOfRMDLiteralNode
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> metaParametersSize [

	^ placeholders size
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> placeholders [

	^ placeholders
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> placeholders: anArrayOfRMDPlaceHolderNode [

	placeholders := anArrayOfRMDPlaceHolderNode
]

{ #category : 'enumerating' }
RMDMetaParameterSetSequenceNode >> placeholdersDo: aBlock [

	placeholders do: aBlock
]

{ #category : 'copying' }
RMDMetaParameterSetSequenceNode >> postCopy [

	placeholders := placeholders collect: #copy.
	literalTuples := literalTuples collect: [ :tuple | 
		                 tuple collect: #copy ]
]

{ #category : 'printing' }
RMDMetaParameterSetSequenceNode >> printOn: aStream [

	placeholders
		do: [ :placeholder | placeholder printOn: aStream ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' -> '.
	literalTuples
		do: [ :tuple | 
			aStream nextPut: $(.
			tuple
				do: [ :literal | literal printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPut: $) ]
		separatedBy: [ 
			aStream
				nextPutAll: ',';
				cr ]
]

{ #category : 'printing' }
RMDMetaParameterSetSequenceNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	placeholders
		do: [ :param | 
			param placeholder
				printOn: aStream
				ifIncludedIn: aCollectionOfRMDSyntaxNode
				addSectionTo: aCollection ]
		separatedBy: [ aStream nextPutAll: ', ' ].
	aStream nextPutAll: ' -> '.
	literalTuples
		do: [ :tuple | 
			aStream nextPut: $(.
			tuple
				do: [ :literal | 
					literal
						printOn: aStream
						ifIncludedIn: aCollectionOfRMDSyntaxNode
						addSectionTo: aCollection ]
				separatedBy: [ aStream nextPutAll: ', ' ].
			aStream nextPut: $) ]
		separatedBy: [ 
			aStream
				nextPutAll: ',';
				cr ].
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : 'rewriting' }
RMDMetaParameterSetSequenceNode >> replaceChildren: aDictionary [

	placeholders := placeholders collect: [ :placeholder | 
		                placeholder copyReplace: aDictionary ].
	literalTuples := literalTuples collect: [ :tuple | 
		                 tuple collect: [ :literal | 
			                 literal copyReplace: aDictionary ] ]
]

{ #category : 'accessing' }
RMDMetaParameterSetSequenceNode >> size [

	^ literalTuples size
]

{ #category : 'operations' }
RMDMetaParameterSetSequenceNode >> withoutPlaceholders: aCollectionOfRMDPlaceholderNode [

	^ ((1 to: placeholders size) reject: [ :index | 
		   aCollectionOfRMDPlaceholderNode includes:
			   (placeholders at: index) ])
		  ifEmpty: [ nil ]
		  ifNotEmpty: [ :aliveIndices | 
			  aliveIndices size > 1
				  ifTrue: [ 
					  | index |
					  index := aliveIndices first.
					  RMDMetaSingleParameterSequenceNode
						  placeholder: (placeholders at: index)
						  literals:
						  (literalTuples collect: [ :tuple | tuple at: index ]) ]
				  ifFalse: [ 
					  RMDMetaParameterSetSequenceNode
						  placeholders:
						  (aliveIndices collect: [ :index | placeholders at: index ])
						  literalTuples: (literalTuples collect: [ :tuple | 
								   aliveIndices collect: [ :index | tuple at: index ] ]) ] ]
]
