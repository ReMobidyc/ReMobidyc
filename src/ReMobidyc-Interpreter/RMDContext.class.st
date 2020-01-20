Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'utilities',
		'propertyDict',
		'script'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDContext >> bindAnimat: anInteger species: aRMDAnimatDefinitionNode propertyBindMap: anArrayOfPropertyBindNode [
	| offsets |
	offsets := aRMDAnimatDefinitionNode propertyOffsets.
	anArrayOfPropertyBindNode
		do: [ :bind | 
			(propertyDict
				at: bind scriptAgent
				ifAbsentPut: [ Dictionary new: anArrayOfPropertyBindNode size ])
				at: bind scriptProperty
				put: (offsets at: bind animatProperty) + anInteger ]
]

{ #category : #accessing }
RMDContext >> getMemoryAddressFor: aString agent: agentReference ifAbsent: errorBlock [
	^ (propertyDict at: agentReference ifAbsent: [ ^ errorBlock value ])
		at: aString
		ifAbsent: errorBlock
]

{ #category : #initialization }
RMDContext >> initialize [
	super initialize.
	propertyDict := Dictionary new.
	utilities := Dictionary new
]

{ #category : #operations }
RMDContext >> loadUtilityDefinitions [
	utilities := Dictionary new: script utilityDefinitions size.
	script utilityDefinitions
		do: [ :def | utilities at: def variable identifier put: def ]
]

{ #category : #accessing }
RMDContext >> script [
	^ script
]

{ #category : #accessing }
RMDContext >> script: aRMDScriptNode [
	script := aRMDScriptNode.
	self loadUtilityDefinitions
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
