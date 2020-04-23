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

{ #category : #'utility access' }
RMDActionContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDActionContext >> location: anInteger species: aRMDCellDefinition [
	| dict |
	location := anInteger.
	cellDefinition := aRMDCellDefinition.
	dict := Dictionary new.
	aRMDCellDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict := Dictionary new
		at: 'here' put: dict;
		yourself
]

{ #category : #accessing }
RMDActionContext >> object: anInteger species: aRMDAnimatDefinition [
	| dict |
	object := anInteger.
	objectSpecies := aRMDAnimatDefinition.
	dict := Dictionary new.
	aRMDAnimatDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict
		at: (action ifNotNil: #object ifNil: [ #object ])
		put: dict
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
RMDActionContext >> world: anInteger species: aRMDWorldDefinition [
	| dict |
	worldDefinition := aRMDWorldDefinition.
	dict := Dictionary new.
	aRMDWorldDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: 'world' put: dict
]
