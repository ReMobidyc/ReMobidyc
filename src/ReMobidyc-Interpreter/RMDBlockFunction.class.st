Class {
	#name : #RMDBlockFunction,
	#superclass : #RMDFunction,
	#instVars : [
		'block'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDBlockFunction class >> block: aBlock [
	^ self new
		block: aBlock;
		yourself
]

{ #category : #accessing }
RMDBlockFunction >> block: aBlock [
	block := aBlock
]

{ #category : #evaluating }
RMDBlockFunction >> value: aNumber [
	block numArgs = 1
		ifFalse: [ ^ self numArgsError ].
	^ block value: aNumber
]

{ #category : #evaluating }
RMDBlockFunction >> value: aNumber1 value: aNumber2 [
	block numArgs = 2
		ifFalse: [ ^ self numArgsError ].
	^ block value: aNumber1 value: aNumber2
]

{ #category : #evaluating }
RMDBlockFunction >> value: aNumber1 value: aNumber2 value: aNumber3 [
	block numArgs = 3
		ifFalse: [ ^ self numArgsError ].
	^ block value: aNumber1 value: aNumber2 value: aNumber3
]

{ #category : #evaluating }
RMDBlockFunction >> value: aNumber1 value: aNumber2 value: aNumber3 value: aNumber4 [
	block numArgs = 4
		ifFalse: [ ^ self numArgsError ].
	^ block
		value: aNumber1
		value: aNumber2
		value: aNumber3
		value: aNumber4
]

{ #category : #evaluating }
RMDBlockFunction >> valueWithArguments: anArrayOfNumber [
	block numArgs = anArrayOfNumber size
		ifFalse: [ ^ self numArgsError ].
	^ block valueWithArguments: anArrayOfNumber
]
