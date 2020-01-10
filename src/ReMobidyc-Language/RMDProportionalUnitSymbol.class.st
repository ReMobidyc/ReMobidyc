Class {
	#name : #RMDProportionalUnitSymbol,
	#superclass : #RMDNonSIUnitSymbol,
	#instVars : [
		'scale'
	],
	#category : #'ReMobidyc-Language-Units'
}

{ #category : #'instance creation' }
RMDProportionalUnitSymbol class >> newSymbol: aString scale: aFloat siUnit: aRMDUnit [
	^ (self newSymbol: aString siUnit: aRMDUnit)
		setScale: aFloat;
		yourself
]

{ #category : #conversions }
RMDProportionalUnitSymbol >> fromSI: aNumber [
	^ aNumber / scale
]

{ #category : #testing }
RMDProportionalUnitSymbol >> isProportional [
	^ true
]

{ #category : #accessing }
RMDProportionalUnitSymbol >> scale [
	^ scale
]

{ #category : #private }
RMDProportionalUnitSymbol >> setScale: aFloat [
	scale := aFloat asFloat
]

{ #category : #conversions }
RMDProportionalUnitSymbol >> toSI: aNumber [
	^ aNumber * scale
]
