Extension { #name : #RMDKillDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDKillDirectiveNodeTest >> testEvalIn [

	| individualA individualB |
	interpreter individualsOf: aDef do: [ :a | individualA := a ].
	interpreter individualsOf: bDef do: [ :b | individualB := b ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithIndividual: individualA
		species: aDef
		object: individualB
		species: bDef
		do: [ RMDKillDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 0
]
