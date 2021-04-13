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
	^ aRMDType unifyWithUnitType: self
]

{ #category : #'type checking' }
RMDUnitType >> unifyWithUnitType: aRMDType [
	unit = aRMDType unit
		ifFalse: [ ^ (RMDTypeUnificationError on: aRMDType and: self) signal ].
	^ self
]

{ #category : #accessing }
RMDUnitType >> unit [
	^ unit
]

{ #category : #accessing }
RMDUnitType >> unit: aRMDUnit [
	unit := aRMDUnit siUnit
]
