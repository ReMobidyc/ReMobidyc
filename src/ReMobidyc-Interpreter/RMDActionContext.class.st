Class {
	#name : #RMDActionContext,
	#superclass : #RMDExecutionContext,
	#instVars : [
		'action',
		'utilities',
		'location',
		'object',
		'objectDefinition',
		'newDefinition',
		'newIndividuals',
		'subjectLifehistory'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDActionContext class >> subjectLifehistory: anArrayOfInteger definition: aRMDSpeciesDefinitionNode [

	^ self new
		  subject: anArrayOfInteger last
		  definition: aRMDSpeciesDefinitionNode;
		  subjectLifehistory: anArrayOfInteger;
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

{ #category : #'utility access' }
RMDActionContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDActionContext >> location [
	^ location
]

{ #category : #accessing }
RMDActionContext >> location: anInteger definition: aRMDCellDefinition agent: aString [
	| dict |
	dict := Dictionary new.
	aRMDCellDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: aString put: dict.
	location := anInteger
]

{ #category : #accessing }
RMDActionContext >> newIndividuals: anArrayOfInteger definition: aRMDAnimatDefinition [

	anArrayOfInteger do: [ :individual | 
		| dict |
		dict := Dictionary new.
		aRMDAnimatDefinition propertyOffsetsDo: [ :identifier :offset | 
			dict at: identifier put: individual + offset ].
		propertyDict at: individual put: dict ].
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
RMDActionContext >> object: anInteger definition: aRMDAnimatDefinition agent: aString [

	| dict |
	dict := Dictionary new.
	aRMDAnimatDefinition propertyOffsetsDo: [ :identifier :offset | 
		dict at: identifier put: anInteger + offset ].
	propertyDict at: aString put: dict.
	object := anInteger.
	objectDefinition := aRMDAnimatDefinition
]

{ #category : #accessing }
RMDActionContext >> objectDefinition [
	^ objectDefinition
]

{ #category : #accessing }
RMDActionContext >> subjectLifehistory [

	^ subjectLifehistory
]

{ #category : #accessing }
RMDActionContext >> subjectLifehistory: anArrayOfInteger [

	subjectLifehistory := anArrayOfInteger
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
RMDActionContext >> world: anInteger definition: aRMDWorldDefinition [
	| dict |
	dict := Dictionary new.
	aRMDWorldDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: 'world' put: dict
]
