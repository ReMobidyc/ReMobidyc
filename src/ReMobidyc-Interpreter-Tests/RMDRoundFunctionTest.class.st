Class {
	#name : #RMDRoundFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'round'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDRoundFunctionTest >> setUp [ 
	round := RMDRoundFunction new
]

{ #category : #tests }
RMDRoundFunctionTest >> testValue [
	self assert: (round value: -1.6) closeTo: -2.0.
	self assert: (round value: 1.6) closeTo: 2.0.
	self assert: (round value: 3.2) closeTo: 3.0.
	self assert: (round value: 10.0) closeTo: 10.0
]

{ #category : #tests }
RMDRoundFunctionTest >> testValueValue [

	self should: [ round value: 1.0 value: 1.0 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDRoundFunctionTest >> testValueValueValue [

	self
		should: [ round value: 1.0 value: 1.0 value: 1.0 ]
		raise: RMDNumArgsError
]

{ #category : #tests }
RMDRoundFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			round
				value: 1.0
				value: 1.0
				value: 1.0
				value: 1.0 ]
		raise: RMDNumArgsError
]
