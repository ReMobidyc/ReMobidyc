Class {
	#name : 'RMDSinFunctionTest',
	#superclass : 'TestCase',
	#instVars : [
		'sin'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'running' }
RMDSinFunctionTest >> setUp [ 
	sin := RMDSinFunction new
]

{ #category : 'tests' }
RMDSinFunctionTest >> testValue [
	self assert: (sin value: 0) closeTo: 0.0.
	self assert: (sin value: Float pi / 2.0) closeTo: 1.0.
	self assert: (sin value: Float pi) closeTo: 0.0
]

{ #category : 'tests' }
RMDSinFunctionTest >> testValueValue [

	self should: [ sin value: 0.0 value: 0.0 ] raise: RMDNumArgsError
]

{ #category : 'tests' }
RMDSinFunctionTest >> testValueValueValue [

	self
		should: [ sin value: 0.0 value: 0.0 value: 0.0 ]
		raise: RMDNumArgsError
]

{ #category : 'tests' }
RMDSinFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			sin
				value: 0.0
				value: 0.0
				value: 0.0
				value: 0.0 ]
		raise: RMDNumArgsError
]
