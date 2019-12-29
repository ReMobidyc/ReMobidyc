Class {
	#name : #RMDUnitSymbol,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'scale'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDUnitSymbol >> isProportinal [
	^ true
]

{ #category : #printing }
RMDUnitSymbol >> printOn: aStream [
	aStream nextPutAll: self symbol
]

{ #category : #private }
RMDUnitSymbol >> setScale: aFloat [
	scale := aFloat asFloat
]

{ #category : #accessing }
RMDUnitSymbol >> symbol [
	^ symbol
]

{ #category : #operations }
RMDUnitSymbol >> toNormalizedValue: aFloat [
	^ aFloat / scale
]
