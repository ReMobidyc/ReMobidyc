Extension { #name : 'RMDPropertyDefinitionNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDPropertyDefinitionNodeTest >> testEvalIn [

	| animatDef animat1 animat2 |
	animatDef := 'Animat is Animat.' asRMDAnimatDefinition.
	animat1 := 1.
	animat2 := 3.
	interpreter memory
		nextAt: 1 put: 3.0;
		nextAt: 2 put: 5.0;
		nextAt: 3 put: 4.0;
		nextAt: 4 put: 6.0;
		tick.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: animat1
		definition: animatDef
		object: animat2
		definition: animatDef
		taskHash: 1
		do: [ 
			self
				assert:
				((parser attributeDefinition parse: 'my x'' = 5') evalIn:
					 interpreter)
				closeTo: 5.
			self assert: (interpreter memory nextAt: 1) closeTo: 5.
			self assert: (interpreter memory at: 1) equals: 3.
			self
				assert:
					((parser attributeDefinition parse: 'bar''s delta x'' = 6') 
						 evalIn: interpreter)
				closeTo: 6.
			self
				assert:
					((parser attributeDefinition parse: 'bar''s delta x'' = 7') 
						 evalIn: interpreter)
				closeTo: 7.
			self assert: (interpreter memory at: 3) equals: 4.
			interpreter memory tick.
			self assert: (interpreter memory at: 1) closeTo: 5.
			self assert: (interpreter memory at: 3) closeTo: 4 + 6 + 7 ]
]
