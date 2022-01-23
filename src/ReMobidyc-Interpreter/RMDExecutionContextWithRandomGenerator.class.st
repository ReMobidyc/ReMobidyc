Class {
	#name : #RMDExecutionContextWithRandomGenerator,
	#superclass : #RMDExecutionContext,
	#instVars : [
		'randomGenerator'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #initialization }
RMDExecutionContextWithRandomGenerator >> initialize [

	super initialize.
	randomGenerator := RMDFishmanMooreRandomGenerator new
]

{ #category : #accessing }
RMDExecutionContextWithRandomGenerator >> nextSeed [

	^ randomGenerator nextSeed
]

{ #category : #accessing }
RMDExecutionContextWithRandomGenerator >> random [
	^ randomGenerator next
]

{ #category : #accessing }
RMDExecutionContextWithRandomGenerator >> randomSeedWithAll: anArray [

	randomGenerator initializeWithAll: anArray
]
