Class {
	#name : #RMDAnimatInitializerNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAnimatInitializerNodeTest >> testCopyReplace [
	| node replacement |
	node := parser animatInitializer end
		parse:
			'10 Goat with
blood_sugar = uniform 1000 [kcal] to 2000 [kcal]'.
	replacement := Dictionary new
		at: (self expression: '1000 [kcal]')
			put: (self expression: '1500 [kcal]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser animatInitializer end
				parse:
					'10 Goat with
blood_sugar = uniform 1500 [kcal] to 2000 [kcal]')
]
