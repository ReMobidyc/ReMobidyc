Class {
	#name : #RMDVariabilityNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'randomSeed',
		'metaParameterSequences',
		'multiplicity'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDVariabilityNode class >> multiplicity: anInteger metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode [

	^ self new
		  multiplicity: anInteger;
		  metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode;
		  yourself
]

{ #category : #'instance creation' }
RMDVariabilityNode class >> random: anIntegerOrNil metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode [

	^ self new
		  randomSeed: anIntegerOrNil;
		  metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode;
		  yourself
]

{ #category : #'instance creation' }
RMDVariabilityNode class >> random: anIntegerOrNil multiplicity: anInteger metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode [

	^ self new
		  randomSeed: anIntegerOrNil;
		  multiplicity: anInteger;
		  metaParameterSequences: anArrayOfRMDMetaParameterSequenceNode;
		  yourself
]

{ #category : #comparing }
RMDVariabilityNode >> = anObject [

	^ self class = anObject class and: [ 
		  randomSeed = anObject randomSeed and: [ 
			  multiplicity = anObject multiplicity and: [ 
				  metaParameterSequences = anObject metaParameterSequences ] ] ]
]

{ #category : #operations }
RMDVariabilityNode >> addPlaceholders: aCollectionOfPlaceholders [

	metaParameterSequences := metaParameterSequences
	                          ,
		                          (aCollectionOfPlaceholders collect: [ 
			                           :placeholder | 
			                           RMDMetaSingleParameterSequenceNode
				                           placeholder: placeholder
				                           literals: { '0.0' asRMDExpression } ])
]

{ #category : #enumerating }
RMDVariabilityNode >> childrenDo: aBlock [

	metaParameterSequences do: aBlock
]

{ #category : #enumerating }
RMDVariabilityNode >> dictionariesDo: aBlock [

	| numParams |
	numParams := metaParameterSequences
		             inject: 0
		             into: [ :sum :each | sum + each metaParametersSize ].
	0
		to: (metaParameterSequences
				 inject: 1
				 into: [ :prod :each | prod * each size ]) - 1
		do: [ :index | 
			| dict i |
			dict := Dictionary new: numParams.
			i := index.
			metaParameterSequences do: [ :paramSeq | 
				(paramSeq
					 dictionaryAt: i % paramSeq size + 1
					 ifAbsent: [ self error ]) keysAndValuesDo: [ :key :value | 
					dict at: key put: value ].
				i := i // paramSeq size ].
			aBlock value: dict ]
]

{ #category : #comparing }
RMDVariabilityNode >> hash [

	^ ((self class hash bitXor: randomSeed hash) bitXor: multiplicity hash) 
		  bitXor: metaParameterSequences hash
]

{ #category : #initialization }
RMDVariabilityNode >> initialize [
	multiplicity := 1.
	randomSeed := nil.
	metaParameterSequences := Array new
]

{ #category : #accessing }
RMDVariabilityNode >> metaParameterSequences [

	^ metaParameterSequences
]

{ #category : #accessing }
RMDVariabilityNode >> metaParameterSequences: anArrayOfRMDParameterSequence [

	metaParameterSequences := anArrayOfRMDParameterSequence
]

{ #category : #accessing }
RMDVariabilityNode >> multiplicity [

	^ multiplicity
]

{ #category : #accessing }
RMDVariabilityNode >> multiplicity: anInteger [

	multiplicity := anInteger
]

{ #category : #copying }
RMDVariabilityNode >> postCopy [

	metaParameterSequences := metaParameterSequences collect: #copy
]

{ #category : #printing }
RMDVariabilityNode >> printOn: aStream [

	aStream nextPutAll: 'Variability'.
	(randomSeed notNil or: [ 
		 multiplicity > 1 or: [ metaParameterSequences notEmpty ] ]) 
		ifTrue: [ 
			aStream nextPutAll: ' with'.
			randomSeed ifNotNil: [ 
				aStream
					cr;
					nextPutAll: 'reproduce random '.
				randomSeed printOn: aStream ].
			multiplicity > 1 ifTrue: [ 
				aStream cr.
				multiplicity printOn: aStream.
				aStream nextPutAll: ' runs each' ].
			metaParameterSequences do: [ :metaParameterSequence | 
				aStream cr.
				metaParameterSequence printOn: aStream ] ].
	aStream nextPut: $.
]

{ #category : #printing }
RMDVariabilityNode >> printOn: aStream ifIncludedIn: aCollectionOfRMDSyntaxNode addSectionTo: aCollection [

	| start |
	start := aStream position + 1.
	aStream nextPutAll: 'Variability'.
	(randomSeed notNil or: [ 
		 multiplicity > 1 or: [ metaParameterSequences notEmpty ] ]) 
		ifTrue: [ 
			aStream nextPutAll: ' with'.
			randomSeed ifNotNil: [ 
				aStream
					cr;
					nextPutAll: 'reproduce random '.
				randomSeed printString ].
			multiplicity > 1 ifTrue: [ 
				aStream cr.
				multiplicity printOn: aStream.
				aStream nextPutAll: ' runs each' ].
			metaParameterSequences do: [ :metaParameterSequence | 
				aStream cr.
				metaParameterSequence
					printOn: aStream
					ifIncludedIn: aCollectionOfRMDSyntaxNode
					addSectionTo: aCollection ] ].
	aStream nextPut: $..
	(aCollectionOfRMDSyntaxNode includes: self) ifTrue: [ 
		aCollection add: (start to: aStream position) ]
]

{ #category : #accessing }
RMDVariabilityNode >> randomSeed [

	^ randomSeed
]

{ #category : #accessing }
RMDVariabilityNode >> randomSeed: anIntegerOrNil [

	randomSeed := anIntegerOrNil
]

{ #category : #operations }
RMDVariabilityNode >> removePlaceholders: aCollectionOfPlaceholders [

	metaParameterSequences := Array streamContents: [ :stream | 
		                          metaParameterSequences do: [ 
			                          :metaParameterSequence | 
			                          (metaParameterSequence 
				                           withoutPlaceholders:
				                           aCollectionOfPlaceholders) ifNotNil: [ 
				                          :newSequence | 
				                          stream nextPut: newSequence ] ] ]
]

{ #category : #rewriting }
RMDVariabilityNode >> replaceChildren: aDictionary [

	metaParameterSequences := metaParameterSequences collect: [ 
		                          :metaParameterSequence | 
		                          metaParameterSequence copyReplace:
			                          aDictionary ]
]
