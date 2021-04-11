Class {
	#name : #RMDLiteralNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDLiteralNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: '10 [kcal]'.
	replacement := Dictionary new
		at: (parser type end parse: '[kcal]')
			put: (parser type end parse: '[J]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [J]')
]

{ #category : #tests }
RMDLiteralNodeTest >> testInferType [
	self
		assert: (parser expression end parse: '10 [s]') inferType
		equals: RMDUnit s
]
