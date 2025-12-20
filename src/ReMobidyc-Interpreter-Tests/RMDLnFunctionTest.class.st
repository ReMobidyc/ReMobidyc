Class {
	#name : 'RMDLnFunctionTest',
	#superclass : 'TestCase',
	#instVars : [
		'ln'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'initialization' }
RMDLnFunctionTest >> setUp [

	super setUp.
	ln := RMDLnFunction new
]

{ #category : 'tests' }
RMDLnFunctionTest >> testValue [

	self assert: (ln value: 0) equals: Float infinity negated.
	self assert: (ln value: 1.0) closeTo: 0.0.
	self assert: (ln value: Float e) closeTo: 1.0.
	self assert: (ln value: 12.3) closeTo: 12.3 ln.
	self should: [ ln value: -1.0 ] raise: ArithmeticError
]

{ #category : 'tests' }
RMDLnFunctionTest >> testValueValue [

	self should: [ ln value: 0.0 value: 0.0 ] raise: RMDNumArgsError
]

{ #category : 'tests' }
RMDLnFunctionTest >> testValueValueValue [

	self
		should: [ ln value: 0.0 value: 0.0 value: 0.0 ]
		raise: RMDNumArgsError
]

{ #category : 'tests' }
RMDLnFunctionTest >> testValueValueValueValue [

	self
		should: [ 
			ln
				value: 0.0
				value: 0.0
				value: 0.0
				value: 0.0 ]
		raise: RMDNumArgsError
]
