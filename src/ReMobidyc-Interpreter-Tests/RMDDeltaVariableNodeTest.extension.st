Extension { #name : 'RMDDeltaVariableNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDDeltaVariableNodeTest >> testAssignIn [

	| animatDef animat address |
	animatDef := RMDGrammar current animatDefinition end parse:
		             'Animat is Animat.'.
	animat := 1.
	address := 1 + (animatDef offsetAt: 'x' ifAbsent: [ self fail ]).
	interpreter memory
		nextAt: address put: 4;
		tick.
	interpreter
		withActionContextWith:
		(RMDGrammar current actionDefinition end parse: 'to do_nothing is.')
		subject: animat
		definition: animatDef
		taskHash: 1
		do: [ 
			self
				assert:
					((parser attributeDefinition parse: 'my delta x'' = 6') evalIn:
						 interpreter)
				closeTo: 6.
			self
				assert:
					((parser attributeDefinition parse: 'my delta x'' = 7') evalIn:
						 interpreter)
				closeTo: 7.
			self assert: (interpreter my: 'x') equals: 4.
			self assert: (interpreter memory at: address) equals: 4.
			interpreter memory tick.
			self assert: (interpreter my: 'x') closeTo: 4 + 6 + 7.
			self assert: (interpreter memory at: address) closeTo: 4 + 6 + 7 ]
]
