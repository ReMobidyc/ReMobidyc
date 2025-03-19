"
I am a simple implementation of Fishman-Moore pseudo-random number generator.

Onghena, P. A theoretical and empirical comparison of mainframe, microcomputer, and pocket calculator pseudorandom number generators. Behavior Research Methods, Instruments, & Computers 25, 384–395 (1993). https://doi.org/10.3758/BF03204529
"
Class {
	#name : 'RMDFishmanMooreRandomGenerator',
	#superclass : 'Object',
	#instVars : [
		'seed'
	],
	#category : 'ReMobidyc-Interpreter-Utilities',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Utilities'
}

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator class >> factor [

	^ 742938285
]

{ #category : 'hashing' }
RMDFishmanMooreRandomGenerator class >> hash: anArrayOfInteger [

	anArrayOfInteger ifEmpty: [ ^ 1 ].
	^ anArrayOfInteger inject: 0 into: [ :hash :x | 
		  (hash * self factor bitXor: x * self factor) \\ self modulo ]
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator class >> modulo [

	^ 2147483647
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> factor [

	^ self class factor
]

{ #category : 'initialization' }
RMDFishmanMooreRandomGenerator >> hash: anArrayOfInteger [

	^ self class hash: anArrayOfInteger
]

{ #category : 'initialization' }
RMDFishmanMooreRandomGenerator >> initialize [

	super initialize.
	seed := Time millisecondClockValue \\ (self modulo - 1) + 1
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> modulo [

	^ self class modulo
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> next [

	^ self
		  nextSeed;
		  value
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> nextInt: anInteger [
	^ (self next * anInteger) truncated + 1
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> nextSeed [

	^ seed := self factor * seed \\ self modulo
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> peek [

	^ (self factor * seed \\ self modulo - 1) asFloat
	  / (self modulo - 1) asFloat
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> seed [
	^ seed
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> seed: anInteger [

	seed := anInteger asInteger.
	seed <= 0 ifTrue: [ 
		^ self error: 'random seed must be a non-zero natural number.' ]
]

{ #category : 'initialization' }
RMDFishmanMooreRandomGenerator >> seedWithHash: anArrayOfInteger [

	seed := self hash: anArrayOfInteger
]

{ #category : 'accessing' }
RMDFishmanMooreRandomGenerator >> value [

	^ (self seed - 1) asFloat / (self modulo - 1) asFloat
]
