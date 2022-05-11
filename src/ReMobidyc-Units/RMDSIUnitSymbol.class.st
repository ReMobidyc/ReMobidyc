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

{ #category : #testing }
RMDSIUnitSymbol >> isTemperature [

	^ self == self class kelvin or: [ 
		  self == self class fahrenheit or: [ self == self class celsius ] ]
]

{ #category : #accessing }
RMDSIUnitSymbol >> siUnit [
	^ self
]

{ #category : #conversions }
RMDSIUnitSymbol >> toSI: aNumber [
	^ aNumber
]
