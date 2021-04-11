Class {
	#name : #RMDFunctionTest,
	#superclass : #TestCase,
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #tests }
RMDFunctionTest >> testAbs [
	| f |
	f := RMDFunction abs.
	self assert: (f value: -10) equals: 10.
	self assert: (f value: 10) equals: 10
]

{ #category : #tests }
RMDFunctionTest >> testCos [
	| f |
	f := RMDFunction cos.
	self assert: (f value: 0) closeTo: 1.0.
	self assert: (f value: Float pi / 2) closeTo: 0.0.
	self assert: (f value: Float pi) closeTo: -1.0.

]

{ #category : #tests }
RMDFunctionTest >> testMax [
	| f |
	f := RMDFunction max.
	self assert: (f value: 3.0 value: 5.0 value: -2.0) closeTo: 5.0
]

{ #category : #tests }
RMDFunctionTest >> testMean [
	| f |
	f := RMDFunction mean.
	self assert: (f value: 3.0 value: 5.0 value: -2.0) closeTo: 2.0
]

{ #category : #tests }
RMDFunctionTest >> testMin [
	| f |
	f := RMDFunction min.
	self assert: (f value: 3.0 value: 5.0 value: -2.0) closeTo: -2.0
]

{ #category : #tests }
RMDFunctionTest >> testSin [
	| f |
	f := RMDFunction sin.
	self assert: (f value: 0) closeTo: 0.0.
	self assert: (f value: Float pi / 2) closeTo: 1.0.
	self assert: (f value: Float pi) closeTo: 0.0.

]

{ #category : #tests }
RMDFunctionTest >> testSum [
	| f |
	f := RMDFunction sum.
	self assert: (f value: 3.0 value: 5.0 value: -2.0) closeTo: 6.0
]
