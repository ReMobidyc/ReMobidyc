Class {
	#name : #RMDFishmanMooreRandomGeneratorTest,
	#superclass : #TestCase,
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #tests }
RMDFishmanMooreRandomGeneratorTest >> testHash [

	| random |
	random := RMDFishmanMooreRandomGenerator new.
	random seed: 1.
	self assert: (random hash: #( 1 )) equals: 742938285.
	self assert: (random hash: #( 1 2 )) equals: 2017296752.
	self assert: (random hash: #( 1 2 3 )) equals: 1522674686
]

{ #category : #tests }
RMDFishmanMooreRandomGeneratorTest >> testNextSeed [

	| random |
	random := RMDFishmanMooreRandomGenerator new.
	random seed: 1.
	self assert: random nextSeed equals: 742938285.
	random seed: 2.
	self assert: random nextSeed equals: 1485876570.
	random seed: 1024.
	self assert: random nextSeed equals: 559592802
]

{ #category : #tests }
RMDFishmanMooreRandomGeneratorTest >> testValue [

	| random |
	random := RMDFishmanMooreRandomGenerator new.
	random seed: 1.
	self assert: random value closeTo: 0.0.
	random seed: 123456789.
	self assert: random value closeTo: 0.05748904688049950346.
	random seed: 987654321.
	self assert: random value closeTo: 0.45991238249457663157.
	random seed: random modulo - 1.
	self assert: random value closeTo: 0.99999999953433871225
]
