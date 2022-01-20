Extension { #name : #RMDNewDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDNewDirectiveNodeTest >> testEvalIn [

	| aLifeHistory |
	interpreter
		individualsOf: aDef
		do: [ :a :lifeHistory | aLifeHistory := lifeHistory ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithIndividual: aLifeHistory
		species: aDef
		do: [ 
			(RMDNewDirectiveNode animatIdentifier: 'B' quantity: 2) evalIn:
				interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 3
]
