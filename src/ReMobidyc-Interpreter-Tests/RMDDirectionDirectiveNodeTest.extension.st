Extension { #name : #RMDDirectionDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDirectionDirectiveNodeTest >> testEvalIn [

	| animatDef animat1 animat2 |
	animatDef := 'Animat is Animat.' asRMDAnimatDefinition.
	animat1 := 1.
	animat2 := 3.
	interpreter memory
		nextAt: 1 put: 2.0;
		nextAt: 2 put: 3.0;
		nextAt: 3 put: 5.0;
		nextAt: 4 put: 7.0;
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
				((parser expression parse: 'direction foo') evalIn: interpreter)
				closeTo: (3 @ 4) theta ]
]
