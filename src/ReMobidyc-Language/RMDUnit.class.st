Class {
	#name : #RMDUnit,
	#superclass : #Object,
	#instVars : [
		'unitSymbolsAndOrders'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDUnit class >> withUnitSymbolsAndOrders: aDictionary [
	^ self new
		setUnitSymbolsAndOrders: aDictionary;
		yourself
]

{ #category : #private }
RMDUnit >> setUnitSymbolsAndOrders: aDictionary [
	unitSymbolsAndOrders := aDictionary
]
