Class {
	#name : #RMDUnitTest,
	#superclass : #TestCase,
	#instVars : [
		'm',
		't',
		'kg',
		'h',
		's',
		'a',
		'k',
		'c'
	],
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #running }
RMDUnitTest >> setUp [
	m := RMDUnitSymbol at: 'm'.
	t := RMDUnitSymbol at: 't'.
	kg := RMDUnitSymbol at: 'kg'.
	h := RMDUnitSymbol at: 'h'.
	s := RMDUnitSymbol at: 's'.
	a := RMDUnitSymbol at: 'a'.
	k := RMDUnitSymbol at: 'K'.
	c := RMDUnitSymbol at: 'C'
]

{ #category : #tests }
RMDUnitTest >> testSiUnit [
	self assert: m siUnit equals: m.
	self assert: kg siUnit equals: kg.
	self assert: s siUnit equals: s.
	self assert: k siUnit equals: k.
	self assert: t siUnit equals: kg.
	self assert: h siUnit equals: s.
	self assert: c siUnit equals: k.
	self assert: a siUnit equals: m * m.
	self assert: (m * t / h) siUnit equals: m * kg / s.
	self assert: (a * c) siUnit equals: m * m * k
]
