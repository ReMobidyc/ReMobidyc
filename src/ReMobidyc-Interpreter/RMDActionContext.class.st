Class {
	#name : #RMDActionContext,
	#superclass : #RMDContext,
	#instVars : [
		'action',
		'cellDefinition',
		'location',
		'object',
		'objectSpecies',
		'utilities',
		'worldDefinition'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDActionContext class >> subject: anInteger species: aRMDSpeciesDefinitionNode propertyBindMap: anArrayOfPropertyBindNode [
	^ self new
		subject: anInteger species: aRMDSpeciesDefinitionNode;
		loadPropertyBindMap: anArrayOfPropertyBindNode;
		yourself
]

{ #category : #accessing }
RMDActionContext >> action [
	^ action
]

{ #category : #accessing }
RMDActionContext >> action: aRMDActionDefinitionNode [
	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions
]

{ #category : #initialization }
RMDActionContext >> initialize [
	super initialize.
	utilities := Dictionary new
]

{ #category : #'memory access' }
RMDActionContext >> loadPropertyBindMap: anArrayOfPropertyBindNode [
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
RMDActionContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDActionContext >> location: anInteger cell: aRMDCellDefinition [
	location := anInteger.
	cellDefinition := aRMDCellDefinition
]

{ #category : #accessing }
RMDActionContext >> object: anInteger species: aRMDAnimatDefinition [
	object := anInteger.
	objectSpecies := aRMDAnimatDefinition
]

{ #category : #'utility access' }
RMDActionContext >> utilityAt: aString ifAbsent: errorBlock [
	^ utilities at: aString ifAbsent: errorBlock
]

{ #category : #'utility access' }
RMDActionContext >> utilityAt: aString put: aNumber [
	^ utilities at: aString put: aNumber
]

{ #category : #accessing }
RMDActionContext >> world: aRMDWorldDefinition [
	worldDefinition := aRMDWorldDefinition
]
