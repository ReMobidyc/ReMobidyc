Extension { #name : #RMDDieDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDieDirectiveNodeTest >> testEvalIn [

	| individual |
	interpreter individualsOf: aDef do: [ :i | individual := i ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithIndividual: individual
		species: aDef
		do: [ RMDDieDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 0.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1
]
