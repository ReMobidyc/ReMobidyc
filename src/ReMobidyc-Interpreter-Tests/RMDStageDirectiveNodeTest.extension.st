Extension { #name : #RMDStageDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDStageDirectiveNodeTest >> testEvalIn [

	| aLifeHistory bLifeHistory newBLifeHistory |
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
		do: [ 
		(RMDStageDirectiveNode animatIdentifier: 'B') evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 0.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 2.
	interpreter individualsOf: bDef do: [ :b :lifeHistory | 
		lifeHistory ~= bLifeHistory ifTrue: [ 
			newBLifeHistory := lifeHistory ] ].
	self assert: aLifeHistory size equals: 1.
	self assert: newBLifeHistory size equals: 2.
	self assert: newBLifeHistory first equals: aLifeHistory last
]
