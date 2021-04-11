Class {
	#name : #RMDAdditionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAdditionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser expression end parse: 'a + target''s b'.
	replacement := Dictionary new
		at: (self expression: 'a') put: (self expression: '10 [kcal]');
		at: (self expression: 'target''s b')
			put: (self expression: '20 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser expression end parse: '10 [kcal] + 20 [kcal]')
]

{ #category : #tests }
RMDAdditionNodeTest >> testInferType [
	| node |
	node := parser expression end parse: '1[m/s] + 2[m/s]'.
	self assert: node inferType equals: RMDUnit m / RMDUnit s.
	node := parser expression end parse: '1[m/s] + 2[m]'.
	self should: [ node inferType ] raise: RMDTypeError
]
