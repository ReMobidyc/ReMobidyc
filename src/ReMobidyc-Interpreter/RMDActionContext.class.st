Class {
	#name : #RMDActionContext,
	#superclass : #RMDExecutionContextWithRandomGenerator,
	#instVars : [
		'action',
		'object',
		'objectDefinition',
		'newDefinition',
		'newIndividuals',
		'locationBlock',
		'patchDefinition',
		'location',
		'space'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDActionContext >> action [
	^ action
]

{ #category : #accessing }
RMDActionContext >> action: aRMDActionDefinitionNode [

	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions: action utilityDefinitions
]

{ #category : #'memory access' }
RMDActionContext >> attributeDictFor: aString [

	aString = 'here' ifTrue: [ 
		^ self createPatchAttributeDict: self location ].
	aString = 'east' ifTrue: [ 
		space
			eastOf: self location
			do: [ :east | ^ self createPatchAttributeDict: east ] ].
	aString = 'west' ifTrue: [ 
		space
			westOf: self location
			do: [ :west | ^ self createPatchAttributeDict: west ].
		^ Dictionary new ].
	aString = 'south' ifTrue: [ 
		space
			southOf: self location
			do: [ :south | ^ self createPatchAttributeDict: south ] ].
	aString = 'north' ifTrue: [ 
		space
			northOf: self location
			do: [ :north | ^ self createPatchAttributeDict: north ] ].
	^ Dictionary new
]

{ #category : #'memory access' }
RMDActionContext >> createPatchAttributeDict: anInteger [

	^ patchDefinition attributeOffsets copy associationsDo: [ :assoc | 
		  assoc value: anInteger + assoc value ]
]

{ #category : #'memory access' }
RMDActionContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [

	^ (attributeDict
		   at: agentReference
		   ifAbsentPut: [ self attributeDictFor: agentReference ])
		  at: aString
		  ifAbsent: errorBlock
]

{ #category : #accessing }
RMDActionContext >> location [

	^ location ifNil: [ location := locationBlock value ]
]

{ #category : #accessing }
RMDActionContext >> location: anInteger agent: aString [

	attributeDict at: aString put: [ 
		patchDefinition attributeOffsets copy do: [ :assoc | 
			assoc value: anInteger + assoc value ] ]
]

{ #category : #accessing }
RMDActionContext >> location: anIntegerOrBlock definition: aRMDPatchDefinition [

	patchDefinition := aRMDPatchDefinition.
	locationBlock := anIntegerOrBlock
]

{ #category : #accessing }
RMDActionContext >> newIndividuals: anArrayOfInteger definition: aRMDAnimatDefinition [

	anArrayOfInteger do: [ :individual | 
		| dict |
		dict := Dictionary new.
		aRMDAnimatDefinition attributeOffsetsDo: [ :identifier :offset | 
			dict at: identifier put: individual + offset ].
		attributeDict at: individual put: dict ].
	newIndividuals := anArrayOfInteger.
	newDefinition := aRMDAnimatDefinition
]

{ #category : #enumerating }
RMDActionContext >> newIndividualsDo: aBlock [

	newIndividuals ifNotNil: [ newIndividuals do: aBlock ]
]

{ #category : #accessing }
RMDActionContext >> object [
	^ object
]

{ #category : #accessing }
RMDActionContext >> object: anInteger definition: aRMDAnimatDefinition [

	| dict |
	dict := Dictionary new.
	aRMDAnimatDefinition attributeOffsetsDo: [ :identifier :offset | 
		dict at: identifier put: anInteger + offset ].
	attributeDict
		at: aRMDAnimatDefinition identifier uncapitalized
		put: dict.
	object := anInteger.
	objectDefinition := aRMDAnimatDefinition
]

{ #category : #accessing }
RMDActionContext >> object: anInteger definition: aRMDAnimatDefinition agent: aString [

	| dict |
	dict := Dictionary new.
	aRMDAnimatDefinition attributeOffsetsDo: [ :identifier :offset | 
		dict at: identifier put: anInteger + offset ].
	attributeDict at: aString put: dict.
	object := anInteger.
	objectDefinition := aRMDAnimatDefinition
]

{ #category : #accessing }
RMDActionContext >> objectDefinition [
	^ objectDefinition
]

{ #category : #accessing }
RMDActionContext >> space [
	^ space
]

{ #category : #accessing }
RMDActionContext >> space: aRMDMemory [

	space := aRMDMemory
]

{ #category : #accessing }
RMDActionContext >> world: anInteger definition: aRMDWorldDefinition [
	| dict |
	dict := Dictionary new.
	aRMDWorldDefinition
		attributeOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	attributeDict at: 'world' put: dict
]

{ #category : #accessing }
RMDActionContext >> worldAttributeDict: aDictionary [

	attributeDict at: 'world' put: aDictionary
]
