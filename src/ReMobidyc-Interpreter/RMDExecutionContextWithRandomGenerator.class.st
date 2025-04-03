Class {
	#name : 'RMDExecutionContextWithRandomGenerator',
	#superclass : 'RMDExecutionContext',
	#instVars : [
		'randomGenerator',
		'utilities'
	],
	#category : 'ReMobidyc-Interpreter-Contexts',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Contexts'
}

{ #category : 'initialization' }
RMDExecutionContextWithRandomGenerator >> initialize [

	super initialize.
	randomGenerator := RMDFishmanMooreRandomGenerator new.
	utilities := Dictionary new
]

{ #category : 'utility access' }
RMDExecutionContextWithRandomGenerator >> loadUtilityDefinitions: anArrayOfRMDUtilityDefinitionNode [

	utilities := Dictionary new:
		             anArrayOfRMDUtilityDefinitionNode size + 10.
	anArrayOfRMDUtilityDefinitionNode do: [ :def | 
		utilities at: def variable identifier put: def ]
]

{ #category : 'accessing' }
RMDExecutionContextWithRandomGenerator >> nextSeed [

	^ randomGenerator nextSeed
]

{ #category : 'accessing' }
RMDExecutionContextWithRandomGenerator >> random [
	^ randomGenerator next
]

{ #category : 'accessing' }
RMDExecutionContextWithRandomGenerator >> randomSeedWithHash: anArray [

	randomGenerator seedWithHash: anArray
]

{ #category : 'utility access' }
RMDExecutionContextWithRandomGenerator >> utilityAt: aString ifAbsent: errorBlock [
	^ utilities at: aString ifAbsent: errorBlock
]

{ #category : 'utility access' }
RMDExecutionContextWithRandomGenerator >> utilityAt: aString put: aNumber [

	^ utilities at: aString put: aNumber
]
