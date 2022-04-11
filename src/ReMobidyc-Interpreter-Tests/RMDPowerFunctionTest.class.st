Class {
	#name : #RMDPowerFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'power'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #initialization }
RMDPowerFunctionTest >> setUp [ 
	power := RMDPowerFunction new
]

{ #category : #initialization }
RMDPowerFunctionTest >> testValue [

	self should: [ power value: 1.0 ] raise: Error
]

{ #category : #initialization }
RMDPowerFunctionTest >> testValueValue [

	self should: [ power value: -1.0 value: 0.0 ] raise: ArithmeticError.
	self assert: (power value: 2.0 value: 3.0) closeTo: 8.0.
	self assert: (power value: 0.0 value: 100.0) closeTo: 0.0
]

{ #category : #tests }
RMDPowerFunctionTest >> testValueValueValue [
	self should: [power value: 0.0 value: 0.0 value: 0.0] raise: Error
]

{ #category : #tests }
RMDPowerFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			power
				value: 0.0
				value: 0.0
				value: 0.0
				value: 0.0 ]
		raise: Error
]
