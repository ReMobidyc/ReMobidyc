Class {
	#name : #RMDSubtractionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDSubtractionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '(a + b) - (c * d)'.
	replacement := Dictionary new
		at: (self expression: 'b') put: (self expression: 'x');
		at: (self expression: 'c') put: (self expression: 'y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '(a + x) - (y * d)')
]

{ #category : #tests }
RMDSubtractionNodeTest >> testInferType [
	| node |
	node := parser expression end parse: '1[m/s] - 2[m/s]'.
	self assert: node inferType equals: RMDUnit m / RMDUnit s.
	node := parser expression end parse: '1[m/s] - 2[m]'.
	self should: [ node inferType ] raise: RMDTypeError
]
