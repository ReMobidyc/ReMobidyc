Class {
	#name : #RMDActionContext,
	#superclass : #RMDContext,
	#instVars : [
		'action',
		'utilities',
		'location',
		'object',
		'objectDefinition'
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
RMDActionContext >> location [
	^ location
]

{ #category : #accessing }
RMDActionContext >> location: anInteger definition: aRMDCellDefinition [
	| dict |
	dict := Dictionary new.
	aRMDCellDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict at: 'here' put: dict.
	location := anInteger
]

{ #category : #accessing }
RMDActionContext >> object [
	^ object
]

{ #category : #accessing }
RMDActionContext >> object: anInteger definition: aRMDAnimatDefinition [
	| dict |
	dict := Dictionary new.
	aRMDAnimatDefinition
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict
		at: (action ifNotNil: #object ifNil: [ #object ])
		put: dict.
	object := anInteger.
	objectDefinition := aRMDAnimatDefinition
]

{ #category : #accessing }
RMDActionContext >> objectDefinition [
	^ objectDefinition
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
