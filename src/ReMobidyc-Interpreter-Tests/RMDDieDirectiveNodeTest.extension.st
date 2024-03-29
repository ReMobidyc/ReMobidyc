Extension { #name : #RMDDieDirectiveNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDDieDirectiveNodeTest >> testEvalIn [

	| individual |
	interpreter individualsOf: aDef do: [ :i | individual := i ].
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 1.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: individual
		definition: aDef
		taskHash: 1
		do: [ RMDDieDirectiveNode new evalIn: interpreter ].
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 0.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 1
]
