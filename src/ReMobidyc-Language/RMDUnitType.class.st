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

	^ [ aRMDType unifyWithUnitType: self ]
		  on: RMDTypeUnificationError
		  do: [ :ex | 
			  ^ (RMDTypeUnificationError type1: ex type2 type2: ex type1)
				    signal ]
]

{ #category : #'type checking' }
RMDUnitType >> unifyWithUnitType: aRMDType [

	unit = aRMDType unit ifFalse: [ 
		^ (RMDTypeUnificationError on: self and: aRMDType) signal ].
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
