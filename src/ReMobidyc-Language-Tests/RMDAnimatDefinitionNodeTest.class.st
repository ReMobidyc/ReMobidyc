Class {
	#name : 'RMDAnimatDefinitionNodeTest',
	#superclass : 'RMDSyntaxNodeTest',
	#category : 'ReMobidyc-Language-Tests',
	#package : 'ReMobidyc-Language-Tests'
}

{ #category : 'tests' }
RMDAnimatDefinitionNodeTest >> testCopyReplace [
	| node replacement |
	node := parser animatDefinition end
		parse:
			'Goat is Animat with
blood_sugar [kcal].'.
	replacement := Dictionary new
		at: (parser attributeDeclaration end parse: 'blood_sugar [kcal]')
			put: (parser attributeDeclaration end parse: 'energy [J]');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals:
			(parser animatDefinition end
				parse:
					'Goat is Animat with
energy [J].')
]

{ #category : 'tests' }
RMDAnimatDefinitionNodeTest >> testPrintOn [

	| node copy |
	node := parser animatDefinition end parse: 'A is Animat with
	x [m].'.
	copy := parser animatDefinition end parse: node printString.
	self assert: copy equals: node.
	node := parser animatDefinition end parse: 'A is Animat.'.
	copy := parser animatDefinition end parse: node printString.
	self assert: copy equals: node
]
