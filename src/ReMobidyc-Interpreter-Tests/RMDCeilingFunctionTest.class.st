Class {
	#name : #RMDCeilingFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'ceiling'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #initialization }
RMDCeilingFunctionTest >> setUp [ 
	ceiling := RMDCeilingFunction new
]

{ #category : #tests }
RMDCeilingFunctionTest >> testValue [

	self assert: (ceiling value: -1.6) closeTo: -1.0.
	self assert: (ceiling value: 1.6) closeTo: 2.0.
	self assert: (ceiling value: 3.2) closeTo: 4.0.
	self assert: (ceiling value: 10.0) closeTo: 10.0
]

{ #category : #tests }
RMDCeilingFunctionTest >> testValueValue [

	self should: [ ceiling value: 1.0 value: 1.0 ] raise: RMDNumArgsError
]

{ #category : #tests }
RMDCeilingFunctionTest >> testValueValueValue [

	self
		should: [ ceiling value: 1.0 value: 1.0 value: 1.0 ]
		raise: RMDNumArgsError
]

{ #category : #tests }
RMDCeilingFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			ceiling
				value: 1.0
				value: 1.0
				value: 1.0
				value: 1.0 ]
		raise: RMDNumArgsError
]
