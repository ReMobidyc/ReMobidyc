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
			'to chase Target is
	when my energy >= my min_active_energy
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
					'to chase Target is
	when my energy >= 10 [kcal]
	my bearing'' = dir
	where
		dir = direction target.')
]

{ #category : #tests }
RMDActionDefinitionNodeTest >> testPlus [
	| node1 node2 sum |
	node1 := parser actionDefinition end
		parse:
			'to chase Target is
	when my energy >= my min_active_energy
	my heading'' = target_direction
	where
		target_direction = direction target.'.
	node2 := parser actionDefinition end
		parse:
			'to run is
	when my energy >= my min_active_energy
	my x'' = cos(my heading) * d
	my y'' = sin(my heading) * d
	where
		d = my speed * delta time.'.
	sum := node1 + node2.
	self assert: sum identifier equals: 'chase_run'.
	self assert: sum object equals: 'Target'.
	self
		assert: sum guard
		equals:
			(parser condition
				parse:
					'my energy >= my min_active_energy and my energy >= my min_active_energy').
	self assert: sum attributeDefinitions size equals: 3.
	self
		assert: sum attributeDefinitions first variable identifier
		equals: 'heading'.
	self
		assert: sum attributeDefinitions second variable identifier
		equals: 'x'.
	self
		assert: sum attributeDefinitions third variable identifier
		equals: 'y'
]

{ #category : #tests }
RMDActionDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser actionDefinition end parse: 'to chase Target is
	when my energy >= my min_active_energy
	my heading'' = target_direction
	where
		target_direction = direction target.'.
	copy := parser actionDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser actionDefinition end parse: 'to starve is
	when my energy < my min_energy
	with die.'.
	copy := parser actionDefinition end parse: node printString.
	self assert: copy equals: node
]

{ #category : #tests }
RMDActionDefinitionNodeTest >> testWithAll [
	| node1 node2 sum |
	node1 := parser actionDefinition end
		parse:
			'to turn is
	my delta heading'' = angle
	where
		angle = my something.'.
	node2 := parser actionDefinition end
		parse:
			'to walk is
	my x'' = cos(angle) * d
	my y'' = sin(angle) * d
	where
		angle = my heading
		d = my speed * delta time.'.
	sum := RMDActionDefinitionNode
		withAll:
			{node1.
			node2}.
	self assert: sum identifier equals: 'turn_walk'.
	self assert: sum object equals: nil.
	self assert: sum guard equals: nil.
	self assert: sum attributeDefinitions size equals: 3.
	self
		assert: sum attributeDefinitions first variable identifier
		equals: 'heading_turn'.
	self
		assert: sum attributeDefinitions second variable identifier
		equals: 'x'.
	self
		assert: sum attributeDefinitions third variable identifier
		equals: 'y'.
	self assert: sum utilityDefinitions size equals: 3.
	self
		assert: sum utilityDefinitions first variable identifier
		equals: 'angle_turn'.
	self
		assert: sum utilityDefinitions second variable identifier
		equals: 'angle_walk'.
	self
		assert: sum utilityDefinitions third variable identifier
		equals: 'd'
]
