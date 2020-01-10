Class {
	#name : #RMDNonProportionalUnitSymbol,
	#superclass : #RMDNonSIUnitSymbol,
	#instVars : [
		'fromSIBlock',
		'toSIBlock'
	],
	#category : #'ReMobidyc-Language-Units'
}

{ #category : #'instance creation' }
RMDNonProportionalUnitSymbol class >> newSymbol: aString fromSI: fromNormalUnitBlock toSI: toNormalUnitBlock siUnit: aRMDUnit [
	^ (self newSymbol: aString siUnit: aRMDUnit)
		setFromSIBlock: fromNormalUnitBlock;
		setToSIBlock: toNormalUnitBlock;
		yourself
]

{ #category : #conversions }
RMDNonProportionalUnitSymbol >> fromSI: aNumber [
	^ fromSIBlock value: aNumber
]

{ #category : #testing }
RMDNonProportionalUnitSymbol >> isProportional [
	^ false
]

{ #category : #private }
RMDNonProportionalUnitSymbol >> setFromSIBlock: aBlock [
	fromSIBlock := aBlock
]

{ #category : #private }
RMDNonProportionalUnitSymbol >> setToSIBlock: aBlock [
	toSIBlock := aBlock
]

{ #category : #conversions }
RMDNonProportionalUnitSymbol >> toSI: aNumber [
	^ toSIBlock value: aNumber
]
