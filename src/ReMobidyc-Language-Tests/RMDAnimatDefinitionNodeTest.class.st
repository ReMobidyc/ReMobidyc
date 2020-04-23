Class {
	#name : #RMDAnimatDefinitionNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDAnimatDefinitionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser animatDefinition end
		parse:
			'Goat is Animat with
blood_sugar [kcal].'.
	replacement := Dictionary new
		at: (parser propertyDeclaration end parse: 'blood_sugar [kcal]')
			put: (parser propertyDeclaration end parse: 'energy [J]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser animatDefinition end
				parse:
					'Goat is Animat with
energy [J].')
]
