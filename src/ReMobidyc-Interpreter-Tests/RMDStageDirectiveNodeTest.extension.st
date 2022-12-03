Extension { #name : #RMDStageDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDStageDirectiveNodeTest >> testEvalIn [

	| individualA individualB newB |
	interpreter individualsOf: aDef do: [ :a | individualA := a ].
	interpreter individualsOf: bDef do: [ :b | individualB := b ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter
		withActionContextWithSubject: individualA
		definition: aDef
		do: [ 
		(RMDStageDirectiveNode animatIdentifier: 'B') evalIn: interpreter ].
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndivisualsOf: aDef) equals: 0.
	self assert: (interpreter numberOfIndivisualsOf: bDef) equals: 2.
	interpreter
		individualsOf: bDef
		do: [ :b | b ~= individualB ifTrue: [ newB := b ] ].
	self assert: (interpreter memory previousStageOf: individualA) isNil.
	self assert: (interpreter memory previousStageOf: individualB) isNil.
	self
		assert: (interpreter memory previousStageOf: newB)
		equals: individualA
]
