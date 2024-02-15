Class {
	#name : #RMDDifferentialVariableNodeTest,
	#superclass : #RMDSyntaxNodeTest,
	#category : #'ReMobidyc-Language-Tests'
}

{ #category : #tests }
RMDDifferentialVariableNodeTest >> testAssignIn [

	| animatDef animat address dt |
	animatDef := RMDGrammar current animatDefinition end parse:
		             'Animat is Animat.'.
	animat := 1.
	address := 1 + (animatDef offsetAt: 'x' ifAbsent: [ self fail ]).
	dt := interpreter deltaTime.
	interpreter memory
		nextAt: address put: 4;
		tick.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: animat
		definition: animatDef
		taskHash: 1
		do: [ 
			self
				assert:
					((parser attributeDefinition parse: 'my d/dt x'' = 6') evalIn:
						 interpreter)
				closeTo: 6.
			self
				assert:
					((parser attributeDefinition parse: 'my d/dt x'' = 7') evalIn:
						 interpreter)
				closeTo: 7.
			self
				assert: (interpreter memory at: address ifAbsent: [ self fail ])
				equals: 4 ].
	interpreter memory tick.
	self
		assert: (interpreter memory at: address)
		closeTo: 4 + (6 * dt) + (7 * dt)
]

{ #category : #tests }
RMDDifferentialVariableNodeTest >> testCopyReplace [
	| node replacement |
	node := parser attributeDefinition end parse: 'my d/dt x'' = foo'.
	replacement := Dictionary new
		at: (parser assignableDifferentialAttributeVariable end parse: 'my d/dt x')
			put: (parser assignableDifferentialAttributeVariable end parse: 'my d/dt y');
		yourself.
	self
		assert: (node copyReplace: replacement)
		equals: (parser attributeDefinition end parse: 'my d/dt y'' = foo')
]
