Class {
	#name : #RMDAbsFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'abs'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDAbsFunctionTest >> setUp [ 
	abs := RMDAbsFunction new
]

{ #category : #tests }
RMDAbsFunctionTest >> testValue [
	self assert: (abs value: -1.0) closeTo: 1.0.
	self assert: (abs value: 1.0) closeTo: 1.0.
	self assert: (abs value: 0.0) closeTo: 0.0
]

{ #category : #tests }
RMDAbsFunctionTest >> testValueValue [

	self should: [ abs value: 1.0 value: 1.0 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDAbsFunctionTest >> testValueValueValue [
	self should: [ abs value: 1.0 value: 1.0 value: 0.0 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDAbsFunctionTest >> testValueValueValueValue [
	self
		should: [ abs
				value: 1.0
				value: 1.0
				value: 0.0
				value: 0.0 ]
		raise: RMDNumArgsError
]
