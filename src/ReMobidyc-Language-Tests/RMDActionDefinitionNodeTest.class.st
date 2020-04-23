Class {
	#name : #RMDActionDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDActionDefinitionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser actionDefinition end
		parse:
			'to chase target is
	presume my energy >= my min_active_energy
	my heading'' = target_direction
	where
		target_direction = direction target.'.
	replacement := Dictionary new
		at: (self expression: 'my heading')
			put: (self expression: 'my bearing');
		at: (self expression: 'my min_active_energy')
			put: (self expression: '10 [kcal]');
		at: (self expression: 'target_direction')
			put: (self expression: 'dir');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser actionDefinition end
				parse:
					'to chase target is
	presume my energy >= 10 [kcal]
	my bearing'' = dir
	where
		dir = direction target.')
]
