Class {
	#name : #RMDAnimatDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAnimatDefinitionNodeTest >> testDefaultPropertyBinds [
	| def |
	def := parser animatDefinition
		parse:
			'Goat is Animat with
	energy [kcal].'.
	self
		assert: def defaultPropertyBinds
		equals:
			{(RMDPropertyBindNode
				actionAgent: nil
				property: 'x'
				animatProperty: 'x').
			(RMDPropertyBindNode
				actionAgent: nil
				property: 'y'
				animatProperty: 'y').
			(RMDPropertyBindNode
				actionAgent: nil
				property: 'energy'
				animatProperty: 'energy')}
]
