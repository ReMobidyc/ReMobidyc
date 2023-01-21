Extension { #name : #RMDVariableNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDVariableNodeTest >> testAssignIn [

	| animatDef animat address |
	animatDef := RMDGrammar new animatDefinition end parse:
		             'Animat is Animat.'.
	animat := 1.
	address := 1 + (animatDef offsetAt: 'x' ifAbsent: [ self fail ]).
	interpreter memory
		nextAt: address put: 3;
		tick.
	interpreter
		withActionContextWith:
		(RMDGrammar new actionDefinition end parse: 'to do_nothing is.')
		subject: animat
		definition: animatDef
		taskHash: 1
		do: [ 
			self
				assert: ((parser assignableAttributeVariable parse: 'my x')
						 assign: 5
						 in: interpreter)
				equals: 5 ].
	self assert: (interpreter memory nextAt: 1) closeTo: 5.
	self assert: (interpreter memory at: 1) equals: 3.
	interpreter memory tick.
	self assert: (interpreter memory at: 1) closeTo: 5
]

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDVariableNodeTest >> testEvalIn [

	| animatDef animat address |
	animatDef := RMDGrammar new animatDefinition end parse:
		             'Animat is Animat.'.
	animat := 1.
	address := 1 + (animatDef offsetAt: 'x' ifAbsent: [ self fail ]).
	interpreter memory
		nextAt: address put: 2;
		tick.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: animat
		definition: animatDef
		taskHash: 1
		do: [ 
			self
				assert: ((parser expression parse: 'my x') evalIn: interpreter)
				closeTo: 2.0.
			self
				should: [ 
				(parser expression parse: 'my nothing') evalIn: interpreter ]
				raise: RMDUndefinedAttributeError.
			self
				should: [ 
				(parser expression parse: 'foo''s y') evalIn: interpreter ]
				raise: RMDUndefinedAnimatError ]
]
