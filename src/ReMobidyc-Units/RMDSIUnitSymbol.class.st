Class {
	#name : #RMDSIUnitSymbol,
	#superclass : #RMDUnitSymbol,
	#category : #'ReMobidyc-Units'
}

{ #category : #'instance creation' }
RMDSIUnitSymbol class >> newSISymbol: aString [
	^ self new
		setSymbol: aString;
		yourself
]

{ #category : #conversions }
RMDSIUnitSymbol >> fromSI: aNumber [
	^ aNumber
]

{ #category : #testing }
RMDSIUnitSymbol >> isProportional [
	^ true
]

{ #category : #accessing }
RMDSIUnitSymbol >> siUnit [
	^ self
]

{ #category : #conversions }
RMDSIUnitSymbol >> toSI: aNumber [
	^ aNumber
]
