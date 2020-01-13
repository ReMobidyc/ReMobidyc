Class {
	#name : #RMDContext,
	#superclass : #Object,
	#instVars : [
		'utilities',
		'propertyDict',
		'script'
	],
	#category : #'ReMobidyc-Language-Interpreter'
}

{ #category : #accessing }
RMDContext >> getMemoryAddressFor: aString agent: anInteger ifAbsent: errorBlock [
	^ (propertyDict at: anInteger ifAbsent: [ ^ errorBlock value ])
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
	utilities removeAll.
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
RMDContext >> setMemoryAddressFor: aString agent: anInteger to: anotherInteger [
	^ (propertyDict at: anInteger ifAbsentPut: [ Dictionary new ])
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
