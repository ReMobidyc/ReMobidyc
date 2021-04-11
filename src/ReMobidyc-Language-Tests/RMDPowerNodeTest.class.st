Class {
	#name : #RMDPowerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDPowerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '(a + b) ^ (c * d)'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '(a + x) ^ (y * d)')
]

{ #category : #tests }
RMDPowerNodeTest >> testInferType [
	self
		assert: (parser expression end parse: '1[m] ^ 2') inferType
		equals: RMDUnit m ** 2
]
