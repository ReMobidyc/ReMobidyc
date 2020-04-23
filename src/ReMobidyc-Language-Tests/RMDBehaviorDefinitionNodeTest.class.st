Class {
	#name : #RMDBehaviorDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDBehaviorDefinitionNodeTest >> testCopyReplace [
	"| node replacement |
	node := parser behaviorDefinition end
		parse:
			'Wolf chase Goat where
	my energy -> sugar
	my speed -> slow_speed.'.
	replacement := Dictionary new
		at: (self expression: 'my energy')
			put: (self expression: 'my blood_sugar');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser behaviorDefinition end
				parse:
					'Wolf chase Goat where
	my blood_sugar -> sugar
	my speed -> slow_speed.')"
]
