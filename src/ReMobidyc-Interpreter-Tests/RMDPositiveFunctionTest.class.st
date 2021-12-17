Class {
	#name : #RMDPositiveFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'positive'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #initialization }
RMDPositiveFunctionTest >> setUp [ 
	positive := RMDPositiveFunction new
]

{ #category : #tests }
RMDPositiveFunctionTest >> testValue [
	self assert: (positive value: -1.0) closeTo: 0.0.
	self assert: (positive value: 1.0) closeTo: 1.0.
	self assert: (positive value: 0.0) closeTo: 0.0
]

{ #category : #tests }
RMDPositiveFunctionTest >> testValueValue [
	self should: [ positive value: 1.0 value: 1.0 ] raise: Error
]

{ #category : #tests }
RMDPositiveFunctionTest >> testValueValueValue [
	self should: [ positive value: 1.0 value: 1.0 value: 1.0] raise: Error
]

{ #category : #tests }
RMDPositiveFunctionTest >> testValueValueValueValue [
	self should: [ positive value: 1.0 value: 1.0 value: 1.0 value: 1.0] raise: Error
]
