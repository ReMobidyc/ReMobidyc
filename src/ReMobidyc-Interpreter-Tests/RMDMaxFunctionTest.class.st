Class {
	#name : #RMDMaxFunctionTest,
	#superclass : #TestCase,
	#instVars : [
		'max'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDMaxFunctionTest >> setUp [
	max := RMDMaxFunction new
]

{ #category : #tests }
RMDMaxFunctionTest >> testInferTypeWithArguments [
	self
		assert:
			(max
				inferTypeWithArguments:
					{'1 [m]' asRMDExpression.
					'3 [cm]' asRMDExpression})
		equals: 'm' asRMDUnit.
	self
		should: [ max
				inferTypeWithArguments:
					{'1 [m]' asRMDExpression.
					'3 [m/s]' asRMDExpression} ]
		raise: RMDTypeError
]

{ #category : #tests }
RMDMaxFunctionTest >> testValue [
	self assert: (max value: 10) equals: 10
]

{ #category : #tests }
RMDMaxFunctionTest >> testValueValue [
	self assert: (max value: 10 value: 20) equals: 20
]

{ #category : #tests }
RMDMaxFunctionTest >> testValueValueValue [
	self assert: (max value: 10 value: 20 value: 15) equals: 20
]

{ #category : #tests }
RMDMaxFunctionTest >> testValueValueValueValue [
	self assert: (max value: 10 value: 20 value: 15 value: -10) equals: 20
]

{ #category : #tests }
RMDMaxFunctionTest >> testValueWithArguments [
	self assert: (max valueWithArguments: #(10)) equals: 10.
	self assert: (max valueWithArguments: #(10 20)) equals: 20.
	self assert: (max valueWithArguments: #(10 20 15)) equals: 20.
	self assert: (max valueWithArguments: #(10 20 15 -10)) equals: 20
]
