Class {
	#name : #RMDExpFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'exp'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #initialization }
RMDExpFunctionTest >> setUp [
	super setUp.
	exp := RMDExpFunction new
]

{ #category : #tests }
RMDExpFunctionTest >> testValue [

	self assert: (exp value: 0) closeTo: 1.0.
	self assert: (exp value: 1.0) closeTo: Float e.
	self assert: (exp value: 12.3) closeTo: 12.3 exp
]

{ #category : #tests }
RMDExpFunctionTest >> testValueValue [
	self should: [exp value: 0.0 value: 0.0] raise: Error
]

{ #category : #tests }
RMDExpFunctionTest >> testValueValueValue [
	self should: [exp value: 0.0 value: 0.0 value: 0.0] raise: Error
]

{ #category : #tests }
RMDExpFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			exp
				value: 0.0
				value: 0.0
				value: 0.0
				value: 0.0 ]
		raise: Error
]
