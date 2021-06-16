Class {
	#name : #RMDCosFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'cos'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDCosFunctionTest >> setUp [
	cos := RMDCosFunction new
]

{ #category : #tests }
RMDCosFunctionTest >> testValue [
	self assert: (cos value: 0) closeTo: 1.0.
	self assert: (cos value: Float pi / 2.0) closeTo: 0.0.
	self assert: (cos value: Float pi) closeTo: -1.0
]

{ #category : #tests }
RMDCosFunctionTest >> testValueValue [
	self should: [cos value: 0.0 value: 0.0] raise: Error
]

{ #category : #tests }
RMDCosFunctionTest >> testValueValueValue [
	self should: [cos value: 0.0 value: 0.0 value: 0.0] raise: Error
]

{ #category : #tests }
RMDCosFunctionTest >> testValueValueValueValue [
	self
		should: [ cos
				value: 0.0
				value: 0.0
				value: 0.0
				value: 0.0 ]
		raise: Error
]
