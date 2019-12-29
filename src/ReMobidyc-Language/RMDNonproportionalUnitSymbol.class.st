Class {
	#name : #RMDNonproportionalUnitSymbol,
	#superclass : #Object,
	#instVars : [
		'toNormalBlock',
		'fromNormalizedBlock'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #private }
RMDNonproportionalUnitSymbol >> setFromNormalizedBlock: aBlock [
	fromNormalizedBlock := aBlock
]

{ #category : #private }
RMDNonproportionalUnitSymbol >> setToNormalBlock: aBlock [
	toNormalBlock := aBlock
]
