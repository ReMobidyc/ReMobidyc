Class {
	#name : #RMDFunction,
	#superclass : #Object,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'typical instances' }
RMDFunction class >> abs [
	^ RMDAbsFunction new
]

{ #category : #'instance creation' }
RMDFunction class >> at: aString [

	aString = 'abs' ifTrue: [ ^ self abs ].
	aString = 'cos' ifTrue: [ ^ self cos ].
	aString = 'exp' ifTrue: [ ^ self exp ].
	aString = 'log' ifTrue: [ ^ self ln ].
	aString = 'ln' ifTrue: [ ^ self ln ].
	aString = 'max' ifTrue: [ ^ self max ].
	aString = 'mean' ifTrue: [ ^ self mean ].
	aString = 'min' ifTrue: [ ^ self min ].
	aString = 'power' ifTrue: [ ^ self power ].
	aString = 'sin' ifTrue: [ ^ self sin ].
	aString = 'sum' ifTrue: [ ^ self sum ].
	aString = 'positive' ifTrue: [ ^ self positive ].
	^ KeyNotFound signal: aString
]

{ #category : #'typical instances' }
RMDFunction class >> cos [
	^ RMDCosFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> exp [
	^ RMDExpFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> ln [
	^ RMDLnFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> max [
	^ RMDMaxFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> mean [
	^ RMDMeanFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> min [
	^ RMDMinFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> positive [
	^ RMDPositiveFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> power [
	^ RMDPowerFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> sin [
	^ RMDSinFunction new
]

{ #category : #'typical instances' }
RMDFunction class >> sum [
	^ RMDSumFunction new
]

{ #category : #private }
RMDFunction >> numArgsError [
	^ RMDNumArgsError signal
]

{ #category : #'type checking' }
RMDFunction >> typecheckWithArguments: anArrayOfRMDExpression in: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDFunction >> value: aNumber [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	^ self numArgsError
]

{ #category : #accessing }
RMDFunction >> valueWithArguments: anArrayOfNumber [
	| arity |
	arity := anArrayOfNumber size.
	arity = 1
		ifTrue: [ ^ self value: anArrayOfNumber first ].
	arity = 2
		ifTrue: [ ^ self value: anArrayOfNumber first value: anArrayOfNumber second ].
	arity = 3
		ifTrue: [ ^ self
				value: anArrayOfNumber first
				value: anArrayOfNumber second
				value: anArrayOfNumber third ].
	arity = 4
		ifTrue: [ ^ self
				value: anArrayOfNumber first
				value: anArrayOfNumber second
				value: anArrayOfNumber third
				value: anArrayOfNumber fourth ].
	^ self numArgsError
]
