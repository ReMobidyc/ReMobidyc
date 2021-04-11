Class {
	#name : #RMDSumFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'sum'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDSumFunctionTest >> setUp [
	sum := RMDSumFunction new
]

{ #category : #running }
RMDSumFunctionTest >> testInferTypeWithArguments [
	self
		assert:
			(sum
				inferTypeWithArguments:
					{'1 [m]' asRMDExpression.
					'3 [cm]' asRMDExpression})
		equals: 'm' asRMDUnit.
	self
		should: [ sum
				inferTypeWithArguments:
					{'1 [m]' asRMDExpression.
					'3 [m/s]' asRMDExpression} ]
		raise: RMDTypeError
]

{ #category : #tests }
RMDSumFunctionTest >> testValue [
	self assert: (sum value: 10) equals: 10
]

{ #category : #tests }
RMDSumFunctionTest >> testValueValue [
	self assert: (sum value: 10 value: 20) equals: 30
]

{ #category : #tests }
RMDSumFunctionTest >> testValueValueValue [
	self assert: (sum value: 10 value: 20 value: 15) equals: 45
]

{ #category : #tests }
RMDSumFunctionTest >> testValueValueValueValue [
	self assert: (sum value: 10 value: 20 value: 15 value: -10) equals: 35
]

{ #category : #tests }
RMDSumFunctionTest >> testValueWithArguments [
	self assert: (sum valueWithArguments: #(10 20 15 -10)) equals: 35
]
