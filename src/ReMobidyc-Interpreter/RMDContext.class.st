Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'utilities',
		'propertyDict',
		'action'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDContext class >> individual: anInteger animat: aRMDAnimatDefinitionNode propertyBindMap: anArrayOfPropertyBindNode [
	^ self new
		individual: anInteger
			animat: aRMDAnimatDefinitionNode
			propertyBindMap: anArrayOfPropertyBindNode;
		yourself
]

{ #category : #accessing }
RMDContext >> action [
	^ action
]

{ #category : #accessing }
RMDContext >> action: aRMDActionDefinitionNode [
	action := aRMDActionDefinitionNode.
	self loadUtilityDefinitions
]

{ #category : #accessing }
RMDContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict at: agentReference ifAbsent: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #accessing }
RMDContext >> individual: anInteger animat: aRMDAnimatDefinitionNode propertyBindMap: anArrayOfPropertyBindNode [
	| offsets |
	offsets := aRMDAnimatDefinitionNode propertyOffsets.
	anArrayOfPropertyBindNode
		do: [ :bind | 
			(propertyDict
				at: bind actionAgent
				ifAbsentPut: [ Dictionary new: anArrayOfPropertyBindNode size ])
				at: bind actionProperty
				put: (offsets at: bind animatProperty) + anInteger ]
]

{ #category : #initialization }
RMDContext >> initialize [
	super initialize.
	propertyDict := Dictionary new.
	utilities := Dictionary new
]

{ #category : #operations }
RMDContext >> loadUtilityDefinitions [
	utilities := Dictionary new: action utilityDefinitions size.
	action utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDContext >> setMemoryAddressFor: aString agent: agentReference to: anotherInteger [
	^ (propertyDict at: agentReference ifAbsentPut: [ Dictionary new ])
		at: aString
		put: anotherInteger
]

{ #category : #accessing }
RMDContext >> utilityAt: aString ifAbsent: errorBlock [
	^ utilities at: aString ifAbsent: errorBlock
]

{ #category : #accessing }
RMDContext >> utilityAt: aString put: aNumber [
	^ utilities at: aString put: aNumber
]
