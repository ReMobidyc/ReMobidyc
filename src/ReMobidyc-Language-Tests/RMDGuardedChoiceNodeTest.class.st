Class {
	#name : #RMDGuardedChoiceNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDGuardedChoiceNodeTest >> testCopyReplace [
	| node replacement |
	node := parser guardedChoice end parse: 'a if x = y, b'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'x') put: (self expression: 'z');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser guardedChoice end parse: 'a if z = y, x')
]

{ #category : #tests }
RMDGuardedChoiceNodeTest >> testInferType [
	self
		assert:
			(parser guardedChoice end parse: '1[m] if 1[s] = 1000[ms], 2[m]')
				inferType
		equals: RMDUnit m.
	self
		should: [ (parser guardedChoice end parse: '1[m] if 1[s] = 1000[ms], 2[m/s]')
				inferType ]
		raise: RMDTypeError.
	self
		should: [ (parser guardedChoice end parse: '1[m] if 1[s] = 1000[m], 2[m]')
				inferType ]
		raise: RMDTypeError
]
