Class {
	#name : #RMDUnitType,
	#superclass : #RMDType,
	#instVars : [
		'unit'
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
	^ RMDType unit: unit * aRMDType unit
]

{ #category : #arithmetics }
RMDUnitType >> ** aNumber [

	^ RMDType unit: unit ** aNumber
]

{ #category : #arithmetics }
RMDUnitType >> / aRMDType [

	aRMDType isAny ifTrue: [ ^ aRMDType ].
	^ RMDType unit: unit / aRMDType unit
]

{ #category : #comparing }
RMDUnitType >> = anObject [
	^ self class = anObject class and: [ unit = anObject unit ]
]

{ #category : #comparing }
RMDUnitType >> hash [
	^ self class hash bitXor: unit hash
]

{ #category : #printing }
RMDUnitType >> printOn: aStream [
	aStream nextPut: $[.
	unit printOn: aStream.
	aStream nextPut: $]
]

{ #category : #'type checking' }
RMDUnitType >> unify: aRMDType [

	(aRMDType isAny or: [ unit = aRMDType unit ]) ifTrue: [ ^ self ].
	^ (RMDTypeUnificationError on: self and: aRMDType) signal
]

{ #category : #accessing }
RMDUnitType >> unit [
	^ unit
]

{ #category : #accessing }
RMDUnitType >> unit: aRMDUnit [
	unit := aRMDUnit siUnit
]
