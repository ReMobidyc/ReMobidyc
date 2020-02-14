Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'subject',
		'subjectSpecies',
		'object',
		'objectSpecies',
		'location',
		'cellDefinition',
		'worldDefinition',
		'action',
		'propertyDict',
		'utilities'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDContext >> action [
	^ action
]

{ #category : #accessing }
RMDContext >> action: aRMDActionDefinitionNode [
	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions
]

{ #category : #'memory access' }
RMDContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict
		at: agentReference
		ifAbsentPut: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDContext >> initialize [
	super initialize.
	propertyDict := Dictionary new.
	utilities := Dictionary new
]

{ #category : #'memory access' }
RMDContext >> loadPropertyBindMap: anArrayOfPropertyBindNode [
	anArrayOfPropertyBindNode
		do: [ :bind | 
			| agent individual species |
			agent := bind actionAgent.
			agent
				ifNil: [ individual := subject.
					species := subjectSpecies ]
				ifNotNil: [ agent = 'here'
						ifTrue: [ individual := location.
							species := cellDefinition ]
						ifFalse: [ agent = 'world'
								ifTrue: [ individual := 1.
									species := worldDefinition ]
								ifFalse: [ individual := object.
									species := objectSpecies ] ] ].
			self
				setMemoryAddressFor: bind actionProperty
				agent: agent
				to: (species propertyOffsets at: bind animatProperty) + individual ]
]

{ #category : #'utility access' }
RMDContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDContext >> location: anInteger cell: aRMDCellDefinition [
	location := anInteger.
	cellDefinition := aRMDCellDefinition
]

{ #category : #accessing }
RMDContext >> object: anInteger species: aRMDAnimatDefinition [
	object := anInteger.
	objectSpecies := aRMDAnimatDefinition
]

{ #category : #'memory access' }
RMDContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (propertyDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDContext >> subject: anInteger species: aRMDAnimatDefinition [
	subject := anInteger.
	subjectSpecies := aRMDAnimatDefinition
]

{ #category : #'utility access' }
RMDContext >> utilityAt: aString ifAbsent: errorBlock [
	^ utilities at: aString ifAbsent: errorBlock
]

{ #category : #'utility access' }
RMDContext >> utilityAt: aString put: aNumber [
	^ utilities at: aString put: aNumber
]

{ #category : #accessing }
RMDContext >> world: aRMDWorldDefinition [
	worldDefinition := aRMDWorldDefinition
]
