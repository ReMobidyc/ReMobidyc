Class {
	#name : #RMDTypecheckContext,
	#superclass : #RMDContext,
	#instVars : [
		'subjectDefinition',
		'objectDefinition',
		'cellDefinition',
		'worldDefinition',
		'properties',
		'utilities',
		'action'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDTypecheckContext >> action [
	^ action
]

{ #category : #accessing }
RMDTypecheckContext >> action: aRMDActionDefinitionNode [
	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions
]

{ #category : #accessing }
RMDTypecheckContext >> cellDefinition [
	^ cellDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> cellDefinition: aRMDCellDefinitionNode [
	| dict |
	cellDefinition := aRMDCellDefinitionNode.
	dict := Dictionary new.
	cellDefinition
		propertyUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	properties at: 'here' put: dict.
	properties at: 'east' put: dict.
	properties at: 'west' put: dict.
	properties at: 'south' put: dict.
	properties at: 'north' put: dict
]

{ #category : #initialization }
RMDTypecheckContext >> initialize [
	super initialize.
	utilities := Dictionary new.
	properties := Dictionary new
]

{ #category : #accessing }
RMDTypecheckContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDTypecheckContext >> object: aString definition: aRMDAnimatDefinitionNode [
	| dict |
	objectDefinition := aRMDAnimatDefinitionNode.
	dict := Dictionary new.
	objectDefinition
		propertyUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	properties at: aString put: dict
]

{ #category : #accessing }
RMDTypecheckContext >> objectDefinition [
	^ objectDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> subjectDefinition [
	^ subjectDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> subjectDefinition: aRMDSpeciesDefinitionNode [
	| dict |
	subjectDefinition := aRMDSpeciesDefinitionNode.
	dict := Dictionary new.
	subjectDefinition
		propertyUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	properties at: nil put: dict
]

{ #category : #accessing }
RMDTypecheckContext >> typeAt: aString ifAbsent: errorBlock [
	^ utilities at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDTypecheckContext >> typeAt: aString put: aRMDType [
	^ utilities at: aString put: aRMDType
]

{ #category : #accessing }
RMDTypecheckContext >> typeOfVariable: aString agent: agentReference ifAbsent: errorBlock [
	^ properties
		at: agentReference
		ifPresent: [ :dict | dict at: aString ifAbsent: errorBlock ]
		ifAbsent: errorBlock
]

{ #category : #accessing }
RMDTypecheckContext >> worldDefinition [
	^ worldDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> worldDefinition: aRMDWorldDefinitionNode [
	| dict |
	worldDefinition := aRMDWorldDefinitionNode.
	dict := Dictionary new.
	worldDefinition
		propertyUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	properties at: 'world' put: dict
]
