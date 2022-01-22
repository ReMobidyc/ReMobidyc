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

{ #category : #initialization }
RMDFishmanMooreRandomGenerator >> initialize [
	super initialize.
	seed := Time millisecondClockValue
]

{ #category : #initialization }
RMDFishmanMooreRandomGenerator >> initializeWithAll: anArrayOfInteger [
	seed := 1.
	anArrayOfInteger
		do:
			[ :int | seed := (seed bitXor: int * 29) * 742938285 \\ 2147483647 ]
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> next [

	^ self nextSeed / 2147483647.0
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> nextInt: anInteger [
	^ (self next * anInteger) truncated + 1
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> nextSeed [

	^ seed := 742938285 * seed \\ 2147483647
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> peek [
	^ 742938285 * seed \\ 2147483647 / 2147483647.0
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> seed [
	^ seed
]

{ #category : #accessing }
RMDFishmanMooreRandomGenerator >> seed: anInteger [

	seed := anInteger asInteger abs + 1 \\ 2147483647
]
