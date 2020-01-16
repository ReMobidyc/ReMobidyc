Class {
	#name : #RMDInterpreter,
	#superclass : #Object,
	#instVars : [
		'memory',
		'libraries',
		'context'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'library access' }
RMDInterpreter >> addLibraries: aCollectionOfDictionary [
	libraries addAll: aCollectionOfDictionary
]

{ #category : #'library access' }
RMDInterpreter >> addLibrary: aDictionary [
	libraries add: aDictionary
]

{ #category : #private }
RMDInterpreter >> context [
	^ context
]

{ #category : #directives }
RMDInterpreter >> direction: aString [
	| x1 y1 x2 y2 |
	x1 := self
		readVariable: 'x'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	y1 := self
		readVariable: 'y'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	x2 := self
		readVariable: 'x'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	y2 := self
		readVariable: 'y'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	^ ((x2 - x1) @ (y2 - y1)) theta
]

{ #category : #directives }
RMDInterpreter >> directive: aString object: anotherString [
	aString = 'direction'
		ifTrue: [ ^ self direction: anotherString ].
	aString = 'distance'
		ifTrue: [ ^ self distance: anotherString ]
]

{ #category : #directives }
RMDInterpreter >> distance: aString [
	| x1 y1 x2 y2 |
	x1 := self
		readVariable: 'x'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	y1 := self
		readVariable: 'y'
		agent: nil
		ifAbsent: [ ^ KeyNotFound signal ].
	x2 := self
		readVariable: 'x'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	y2 := self
		readVariable: 'y'
		agent: aString
		ifAbsent: [ ^ KeyNotFound signal ].
	^ ((x1 - x2) squared + (y1 - y2) squared) sqrt
]

{ #category : #'library access' }
RMDInterpreter >> functionAt: aString ifAbsent: errorBlock [
	libraries
		do:
			[ :library | library at: aString ifPresent: [ :function | ^ function ] ].
	^ errorBlock value
]

{ #category : #initialization }
RMDInterpreter >> initialize [
	super initialize.
	libraries := OrderedCollection new
]

{ #category : #'animat operations' }
RMDInterpreter >> initializeAnimat: anInteger species: aRMDAnimatDefinitionNode [
	| offsets |
	offsets := aRMDAnimatDefinitionNode propertyOffsets.
	memory at: anInteger + (offsets at: 'x') put: self random * 1000.0.
	memory at: anInteger + (offsets at: 'y') put: self random * 1000.0.
	memory
		at: anInteger + (offsets at: 'heading')
		put: Float pi * 2 * self random.
	aRMDAnimatDefinitionNode propertyDeclarations
		do: [ :property | 
			memory
				at: anInteger + (offsets at: property identifier)
				put: (property expression evalIn: self) ]
]

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
]

{ #category : #private }
RMDInterpreter >> random [
	^ SharedRandom globalGenerator next
]

{ #category : #'variable access' }
RMDInterpreter >> readDelta: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		deltaAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferential2: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		differential2At:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferential: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		differentialAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'variable access' }
RMDInterpreter >> readUtility: aString ifAbsent: errorBlock [
	^ (context utilityAt: aString ifAbsent: errorBlock) evalIn: self
]

{ #category : #'variable access' }
RMDInterpreter >> readVariable: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		at:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		ifAbsent: errorBlock
]

{ #category : #'animat operations' }
RMDInterpreter >> script: aRMDScriptNode species: aRMDAnimatDefinitionNode replaceMap: anArrayOfAssociation [
	memory
		individualsOf: aRMDAnimatDefinitionNode
		do: [ :animat | 
			context := RMDContext new
				animat: animat
					agent: nil
					species: aRMDAnimatDefinitionNode
					replaceMap: anArrayOfAssociation;
				script: aRMDScriptNode;
				yourself.
			aRMDScriptNode evalIn: self ]
]

{ #category : #private }
RMDInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #timing }
RMDInterpreter >> tick [
	memory tick
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toDelta: aString agent: anotherString ifAbsent: errorBlock [
	memory
		nextDeltaAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		add: aNumber.
	^ aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toUtility: aString [
	^ context utilityAt: aString put: aNumber
]

{ #category : #'variable access' }
RMDInterpreter >> write: aNumber toVariable: aString agent: anotherString ifAbsent: errorBlock [
	^ memory
		nextAt:
			(context
				getMemoryAddressFor: aString
				agent: anotherString
				ifAbsent: [ ^ errorBlock value ])
		put: aNumber
]
