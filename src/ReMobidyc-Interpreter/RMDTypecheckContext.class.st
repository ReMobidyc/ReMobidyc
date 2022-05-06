Class {
	#name : #RMDTypecheckContext,
	#superclass : #RMDContext,
	#instVars : [
		'subjectDefinition',
		'objectDefinition',
		'worldDefinition',
		'utilities',
		'action',
		'newDefinition',
		'attributes',
		'patchDefinition'
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

{ #category : #initialization }
RMDTypecheckContext >> initialize [
	super initialize.
	utilities := Dictionary new.
	attributes := Dictionary new
]

{ #category : #accessing }
RMDTypecheckContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDTypecheckContext >> newDefinition: aRMDAnimatDefinitionNode [

	| dict |
	newDefinition := aRMDAnimatDefinitionNode.
	dict := Dictionary new.
	newDefinition attributeUnitsDo: [ :identifier :unit | 
		dict at: identifier put: (RMDType unit: unit) ].
	attributes at: 'new' put: dict
]

{ #category : #accessing }
RMDTypecheckContext >> object: aString definition: aRMDAnimatDefinitionNode [
	| dict |
	objectDefinition := aRMDAnimatDefinitionNode.
	dict := Dictionary new.
	objectDefinition
		attributeUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	attributes at: aString uncapitalized put: dict
]

{ #category : #accessing }
RMDTypecheckContext >> objectDefinition [
	^ objectDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> patchDefinition [
	^ patchDefinition
]

{ #category : #accessing }
RMDTypecheckContext >> patchDefinition: aRMDPatchDefinitionNode [
	| dict |
	patchDefinition := aRMDPatchDefinitionNode.
	dict := Dictionary new.
	patchDefinition
		attributeUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	attributes at: 'here' put: dict.
	attributes at: 'east' put: dict.
	attributes at: 'west' put: dict.
	attributes at: 'south' put: dict.
	attributes at: 'north' put: dict
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
		attributeUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	attributes at: nil put: dict
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
	^ attributes
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
		attributeUnitsDo: [ :identifier :unit | dict at: identifier put: (RMDType unit: unit) ].
	attributes at: 'world' put: dict
]
