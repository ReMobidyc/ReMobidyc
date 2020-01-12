Class {
	#name : #RMDInterpreter,
	#superclass : #Object,
	#instVars : [
		'memory',
		'deltas'
	],
	#category : #'ReMobidyc-Language-Interpreter'
}

{ #category : #'symbol mapping' }
RMDInterpreter >> getMemoryAddressFor: aString agent: anInteger [
	^ self notYetImplemented 
]

{ #category : #'variable access' }
RMDInterpreter >> readDeltaAt: aString agent: anInteger [
	^ memory
		deltaAt: (self getMemoryAddressFor: aString agent: anInteger)
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferential2At: aString agent: anInteger [
	^ memory
		differential2At: (self getMemoryAddressFor: aString agent: anInteger)
]

{ #category : #'variable access' }
RMDInterpreter >> readDifferentialAt: aString agent: anInteger [
	^ memory
		differentialAt: (self getMemoryAddressFor: aString agent: anInteger)
]

{ #category : #'variable access' }
RMDInterpreter >> readUtilityAt: aString [
	^ self notYetImplemented
]

{ #category : #'variable access' }
RMDInterpreter >> readVariableAt: aString agent: anInteger [
	^ memory
		deltaAt: (self getMemoryAddressFor: aString agent: anInteger)
]

{ #category : #private }
RMDInterpreter >> setMemory: aRMDMemory [
	memory := aRMDMemory
]

{ #category : #'variable access' }
RMDInterpreter >> writeDeltaAt: aString agent: anInteger put: aNumber [
	| binds |
	binds := deltas at: anInteger ifAbsentPut: [ Dictionary new: 10 ].
	binds at: aString put: (binds at: aString ifAbsent: [ 0 ]) + aNumber
]
