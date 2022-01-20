Extension { #name : #RMDKillDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDKillDirectiveNodeTest >> testEvalIn [

	| aLifeHistory bLifeHistory |
	interpreter
		individualsOf: aDef
		do: [ :a :lifeHistory | aLifeHistory := lifeHistory ].
	interpreter
		individualsOf: bDef
		do: [ :b :lifeHistory | bLifeHistory := lifeHistory ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithIndividual: aLifeHistory
		species: aDef
		object: bLifeHistory
		species: bDef
		do: [ RMDKillDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 0
]
