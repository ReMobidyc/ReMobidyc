Class {
	#name : #RMDSquareRootFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'sqrt'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #initialization }
RMDSquareRootFunctionTest >> setUp [

	sqrt := RMDSquareRootFunction new
]

{ #category : #tests }
RMDSquareRootFunctionTest >> testValue [

	self assert: (sqrt value: 0) closeTo: 0.0.
	self assert: (sqrt value: 12.3 squared) closeTo: 12.3.
	self should: [ sqrt value: -1.0 ] raise: ArithmeticError
]
