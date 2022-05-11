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
RMDFunctionTest >> testExp [

	| exp |
	exp := RMDFunction exp.
	self assert: (exp value: 0) closeTo: 1.0.
	self assert: (exp value: 1.0) closeTo: Float e.
	self assert: (exp value: 12.3) closeTo: 12.3 exp
]

{ #category : #tests }
RMDFunctionTest >> testLn [

	| ln |
	ln := RMDFunction ln.
	self assert: (ln value: 0) equals: Float infinity negated.
	self assert: (ln value: 1.0) closeTo: 0.0.
	self assert: (ln value: Float e) closeTo: 1.0.
	self assert: (ln value: 12.3) closeTo: 12.3 ln.
	self should: [ ln value: -1.0 ] raise: ArithmeticError
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
RMDFunctionTest >> testPositive [
	| f |
	f := RMDFunction positive.
	self assert: (f value: -10) equals: 0.
	self assert: (f value: -20.0) equals: 0.0.
	self assert: (f value: 10) equals: 10
]

{ #category : #tests }
RMDFunctionTest >> testPower [

	| power |
	power := RMDFunction power.
	self should: [ power value: -1.0 value: 0.0 ] raise: ArithmeticError.
	self assert: (power value: 2.0 value: 3.0) closeTo: 8.0.
	self assert: (power value: 0.0 value: 100.0) closeTo: 0.0
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
RMDFunctionTest >> testSqrt [

	| sqrt |
	sqrt := RMDFunction sqrt.
	self assert: (sqrt value: 0) equals: 0.0.
	self assert: (sqrt value: 1.0) closeTo: 1.0.
	self assert: (sqrt value: 12.3 squared) closeTo: 12.3.
	self should: [ sqrt value: -1.0 ] raise: ArithmeticError
]

{ #category : #tests }
RMDFunctionTest >> testSum [
	| f |
	f := RMDFunction sum.
	self assert: (f value: 3.0 value: 5.0 value: -2.0) closeTo: 6.0
]
