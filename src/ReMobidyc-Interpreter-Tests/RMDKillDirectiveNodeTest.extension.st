Extension { #name : #RMDKillDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDKillDirectiveNodeTest >> testEvalIn [

	| individualA individualB |
	interpreter individualsOf: aDef do: [ :a | individualA := a ].
	interpreter individualsOf: bDef do: [ :b | individualB := b ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: individualA
		definition: aDef
		object: individualB
		definition: bDef
		taskHash: 1
		do: [ RMDKillDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 0
]
