Class {
	#name : 'RMDGaussianFunctionTest',
	#superclass : 'TestCase',
	#instVars : [
		'gaussian'
	],
	#category : 'ReMobidyc-Interpreter-Tests',
	#package : 'ReMobidyc-Interpreter-Tests'
}

{ #category : 'running' }
RMDGaussianFunctionTest >> setUp [
	super setUp.
	gaussian := RMDGaussianFunction new
]

{ #category : 'tests' }
RMDGaussianFunctionTest >> testValueValueValueValue [

	self
		assert: (gaussian
				 value: 83.33
				 value: 21.08
				 value: 4.348 / 2.0 sqrt
				 value: 20.0)
		closeTo: 78.34412675162746
]
