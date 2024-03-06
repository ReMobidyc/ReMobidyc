Class {
	#name : #RMDUnitType,
	#superclass : #RMDType,
	#instVars : [
		'originalUnit'
	],
	#category : #'ReMobidyc-Language-Type'
}

{ #category : #'instance creation' }
RMDUnitType class >> unit: aRMDUnit [
	^ self new
		unit: aRMDUnit;
		yourself
]

{ #category : #arithmetics }
RMDUnitType >> * aRMDType [

	aRMDType isAny ifTrue: [ ^ aRMDType ].
	^ RMDType unit: originalUnit * aRMDType originalUnit
]

{ #category : #arithmetics }
RMDUnitType >> ** aNumber [

	^ RMDType unit: originalUnit ** aNumber
]

{ #category : #arithmetics }
RMDUnitType >> / aRMDType [

	aRMDType isAny ifTrue: [ ^ aRMDType ].
	^ RMDType unit: originalUnit / aRMDType originalUnit
]

{ #category : #comparing }
RMDUnitType >> = anObject [

	^ self class = anObject class and: [
		  originalUnit = anObject originalUnit ]
]

{ #category : #comparing }
RMDUnitType >> hash [

	^ self class hash bitXor: originalUnit hash
]

{ #category : #accessing }
RMDUnitType >> originalUnit [

	^ originalUnit
]

{ #category : #printing }
RMDUnitType >> printOn: aStream [

	aStream nextPut: $[.
	self unit printOn: aStream.
	aStream nextPut: $]
]

{ #category : #'type checking' }
RMDUnitType >> unify: aRMDType [

	(aRMDType isAny or: [ self unit = aRMDType unit ]) ifTrue: [ ^ self ].
	^ (RMDTypeUnificationError on: self and: aRMDType) signal
]

{ #category : #accessing }
RMDUnitType >> unit [

	^ originalUnit siUnit
]

{ #category : #accessing }
RMDUnitType >> unit: aRMDUnit [

	originalUnit := aRMDUnit
]
