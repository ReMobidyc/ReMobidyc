Extension { #name : 'RMDDeltaTimeDirectiveNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDDeltaTimeDirectiveNodeTest >> testEvalIn [

	self
		assert:
		((parser expression parse: 'delta time') evalIn: interpreter)
		closeTo: interpreter simulationModel deltaTime
]
