Extension { #name : #RMDTimeDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDTimeDirectiveNodeTest >> testEvalIn [

	interpreter tick.
	self
		assert: ((parser expression parse: 'time') evalIn: interpreter)
		closeTo: interpreter time.
	self
		assert:
		((parser expression parse: 'delta time') evalIn: interpreter)
		closeTo: interpreter deltaTime
]
