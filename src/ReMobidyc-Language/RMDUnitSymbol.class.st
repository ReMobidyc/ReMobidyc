Class {
	#name : #RMDUnitSymbol,
	#superclass : #RMDUnit,
	#instVars : [
		'symbol'
	],
	#category : #'ReMobidyc-Language-Units'
}

{ #category : #arithmetics }
RMDUnitSymbol >> * aRMDUnit [
	^ self asCompoundUnit * aRMDUnit
]

{ #category : #arithmetics }
RMDUnitSymbol >> ** anInteger [
	^ self asCompoundUnit ** anInteger
]

{ #category : #arithmetics }
RMDUnitSymbol >> / aRMDUnit [
	^ self asCompoundUnit / aRMDUnit
]

{ #category : #conversions }
RMDUnitSymbol >> asCompoundUnit [
	^ RMDCompoundUnit with: self
]

{ #category : #testing }
RMDUnitSymbol >> isCompound [
	^ false
]

{ #category : #printing }
RMDUnitSymbol >> printOn: aStream [
	aStream nextPutAll: self symbol
]

{ #category : #private }
RMDUnitSymbol >> setSymbol: aString [
	symbol := aString
]

{ #category : #accessing }
RMDUnitSymbol >> symbol [
	^ symbol
]

{ #category : #enumerating }
RMDUnitSymbol >> symbolsAndOrdersDo: aBlock [
	aBlock value: self value: 1
]
