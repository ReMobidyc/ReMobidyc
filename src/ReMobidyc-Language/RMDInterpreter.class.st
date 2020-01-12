Class {
	#name : #RMDInterpreter,
	#superclass : #Object,
	#instVars : [
		'memory',
		'libraries',
		'context'
	],
	#category : #'ReMobidyc-Language-Interpreter'
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

{ #category : #private }
RMDInterpreter >> memory [
	^ memory
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

{ #category : #private }
RMDInterpreter >> setContext: aRMDContext [
	context := aRMDContext
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
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
