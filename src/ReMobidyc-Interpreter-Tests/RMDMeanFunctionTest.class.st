Class {
	#name : #RMDMeanFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'mean'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDMeanFunctionTest >> setUp [
	mean := RMDMeanFunction new
]

{ #category : #tests }
RMDMeanFunctionTest >> testValue [
	self assert: (mean value: 10) equals: 10
]

{ #category : #tests }
RMDMeanFunctionTest >> testValueValue [
	self assert: (mean value: 10 value: 20) equals: 15
]

{ #category : #tests }
RMDMeanFunctionTest >> testValueValueValue [
	self assert: (mean value: 10 value: 20 value: 15) equals: 15
]

{ #category : #tests }
RMDMeanFunctionTest >> testValueValueValueValue [
	self
		assert:
			(mean
				value: 10
				value: 20
				value: 15
				value: -10)
		closeTo: 35 / 4
]

{ #category : #tests }
RMDMeanFunctionTest >> testValueWithArguments [
	self
		assert: (mean valueWithArguments: #(10 20 15 -10))
		closeTo: 35 / 4
]
