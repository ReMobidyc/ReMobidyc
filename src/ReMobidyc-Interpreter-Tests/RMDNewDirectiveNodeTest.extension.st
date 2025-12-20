Extension { #name : 'RMDNewDirectiveNodeTest' }

{ #category : '*ReMobidyc-Interpreter-Tests' }
RMDNewDirectiveNodeTest >> testEvalIn [

	| individual |
	interpreter individualsOf: aDef do: [ :id | individual := id ].
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 1.
	interpreter
		withActionContextWith: RMDActionDefinitionNode template
		subject: individual
		definition: aDef
		taskHash: 1
		do: [ 
			(RMDNewDirectiveNode animatIdentifier: 'B' quantity: 2) evalIn:
				interpreter ].
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 1.
	interpreter tick.
	self assert: (interpreter numberOfIndividualsOf: aDef) equals: 1.
	self assert: (interpreter numberOfIndividualsOf: bDef) equals: 3
]
