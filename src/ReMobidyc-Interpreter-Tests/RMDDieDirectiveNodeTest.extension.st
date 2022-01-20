Extension { #name : #RMDDieDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDieDirectiveNodeTest >> testEvalIn [

	| aLifeHistory |
	interpreter
		individualsOf: aDef
		do: [ :a :lifeHistory | aLifeHistory := lifeHistory ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithIndividual: aLifeHistory
		species: aDef
		do: [ RMDDieDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 0.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1
]
