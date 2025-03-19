Class {
	#name : 'RMDFunction',
	#superclass : 'Object',
	#category : 'ReMobidyc-Interpreter-Libraries',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Libraries'
}

{ #category : 'typical instances' }
RMDFunction class >> abs [
	^ RMDAbsFunction new
]

{ #category : 'instance creation' }
RMDFunction class >> at: aString [

	^ self at: aString ifAbsent: [ KeyNotFound signal: aString ]
]

{ #category : 'instance creation' }
RMDFunction class >> at: aString ifAbsent: errorBlock [

	aString = 'abs' ifTrue: [ ^ self abs ].
	aString = 'cos' ifTrue: [ ^ self cos ].
	aString = 'exp' ifTrue: [ ^ self exp ].
	aString = 'log' ifTrue: [ ^ self ln ].
	aString = 'ln' ifTrue: [ ^ self ln ].
	aString = 'max' ifTrue: [ ^ self max ].
	aString = 'mean' ifTrue: [ ^ self mean ].
	aString = 'min' ifTrue: [ ^ self min ].
	aString = 'power' ifTrue: [ ^ self power ].
	aString = 'sqrt' ifTrue: [ ^ self sqrt ].
	aString = 'sin' ifTrue: [ ^ self sin ].
	aString = 'sum' ifTrue: [ ^ self sum ].
	aString = 'positive' ifTrue: [ ^ self positive ].
	aString = 'round' ifTrue: [ ^ self round ].
	aString = 'floor' ifTrue: [ ^ self floor ].
	aString = 'ceiling' ifTrue: [ ^ self ceiling ].
	aString = 'gaussian' ifTrue: [ ^ self gaussian ].
	^ errorBlock cull: aString
]

{ #category : 'typical instances' }
RMDFunction class >> ceiling [
	^ RMDCeilingFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> cos [
	^ RMDCosFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> exp [
	^ RMDExpFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> floor [
	^ RMDFloorFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> gaussian [
	^ RMDGaussianFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> ln [
	^ RMDLnFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> max [
	^ RMDMaxFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> mean [
	^ RMDMeanFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> min [
	^ RMDMinFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> positive [
	^ RMDPositiveFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> power [
	^ RMDPowerFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> round [
	^ RMDRoundFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> sin [
	^ RMDSinFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> sqrt [
	^ RMDSquareRootFunction new
]

{ #category : 'typical instances' }
RMDFunction class >> sum [
	^ RMDSumFunction new
]

{ #category : 'accessing' }
RMDFunction >> expectedNumArgs [

	^ self subclassResponsibility
]

{ #category : 'private' }
RMDFunction >> numArgsError [
	^ RMDNumArgsError signal
]

{ #category : 'private' }
RMDFunction >> numArgsError: actual expected: expected [

	^ RMDNumArgsError signal: self actual: actual expected: expected
]

{ #category : 'type checking' }
RMDFunction >> typecheckWithArguments: anArrayOfRMDExpression for: aRMDApplyNode in: aRMDInterpreter [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
RMDFunction >> value: aNumber [

	^ self numArgsError: 1 expected: self expectedNumArgs
]

{ #category : 'accessing' }
RMDFunction >> value: aNumber1 value: aNumber2 [
	^ self numArgsError: 2 expected: self expectedNumArgs
]

{ #category : 'accessing' }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [

	^ self numArgsError: 3 expected: self expectedNumArgs
]

{ #category : 'accessing' }
RMDFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [

	^ self numArgsError: 4 expected: self expectedNumArgs
]

{ #category : 'accessing' }
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
	^ self numArgsError: arity expected: self expectedNumArgs
]
