"
I am a simple implementation of Fishman-Moore pseudo-random number generator.

Onghena, P. A theoretical and empirical comparison of mainframe, microcomputer, and pocket calculator pseudorandom number generators. Behavior Research Methods, Instruments, & Computers 25, 384–395 (1993). https://doi.org/10.3758/BF03204529
"
Class {
	#name : #RMDFishmanMooreRandomGenerator,
	#superclass : #Object,
	#instVars : [
		'seed'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> factor [

	^ 742938285
]

{ #category : #initialization }
RMDFishmanMooreRandomGenerator >> hash: anArrayOfInteger [

	| hash |
	anArrayOfInteger ifEmpty: [ ^ 1 ].
	hash := anArrayOfInteger first.
	2 to: anArrayOfInteger size do: [ :i | 
		| x |
		x := (anArrayOfInteger at: i) abs + 1.
		hash := (x * self factor bitXor: hash) \\ self modulo ].
	^ hash * self factor \\ self modulo
]

{ #category : #initialization }
RMDFishmanMooreRandomGenerator >> initialize [
	super initialize.
	seed := Time millisecondClockValue
]

{ #category : #initialization }
RMDFishmanMooreRandomGenerator >> initializeWithAll: anArrayOfInteger [

	seed := self hash: anArrayOfInteger
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> modulo [

	^ 2147483647
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> next [

	^ (self nextSeed - 1) asFloat / (self modulo - 1) asFloat
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> nextInt: anInteger [
	^ (self next * anInteger) truncated + 1
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> nextSeed [

	^ seed := self factor * seed \\ self modulo
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> peek [

	^ (self factor * seed \\ self modulo - 1) asFloat
	  / (self modulo - 1) asFloat
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> seed [
	^ seed
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> seed: anInteger [

	seed := anInteger asInteger.
	seed <= 0 ifTrue: [ 
		^ self error: 'random seed must be a non-zero natural number.' ]
]
