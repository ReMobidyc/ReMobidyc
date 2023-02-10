Class {
	#name : #RMDNonSIUnitSymbol,
	#superclass : #RMDUnitSymbol,
	#instVars : [
		'siUnit'
	],
	#category : #'ReMobidyc-Units'
}

{ #category : #testing }
RMDNonSIUnitSymbol class >> isAbstract [

	^ self = RMDNonSIUnitSymbol
]

{ #category : #'instance creation' }
RMDNonSIUnitSymbol class >> newSymbol: aString siUnit: anRMDUnit [
	^ self new
		setSymbol: aString;
		setSIUnit: anRMDUnit;
		yourself
]

{ #category : #private }
RMDNonSIUnitSymbol >> setSIUnit: aRMDUnit [
	siUnit := aRMDUnit
]

{ #category : #accessing }
RMDNonSIUnitSymbol >> siUnit [
	^ siUnit ifNil: [ self ]
]
