Extension { #name : #RMDCellInitializerNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDCellInitializerNodeTest >> testEvalIn [
	| cellDef cellInitializer grass fertility count |
	cellDef := parser cellDefinition end
		parse:
			'Cell with
	grass [kcal]
	fertility [kcal].'.
	cellInitializer := parser cellInitializer
		parse:
			'10 x 11 of 2 [m] Cell with
			grass = 1000 [ kcal ]
			fertility = 1100 [kcal]'.
	interpreter allocateCells: cellDef x: 10 y: 11.
	interpreter
		individualsOf: cellDef
		do: [ :cell | 
			interpreter setInitializerContextWithSubject: cell species: cellDef.
			cellInitializer evalIn: interpreter ].
	self assert: interpreter time closeTo: 0.0.
	grass := 'kcal' asRMDUnit toSI: 1000.
	fertility := 'kcal' asRMDUnit toSI: 1100.
	count := 0.
	interpreter
		individualsOf: cellDef
		do: [ :cell | 
			interpreter setActionContextWithIndividual: cell species: cellDef.
			self
				assert: (interpreter readVariable: 'grass' agent: nil ifAbsent: [ nil ])
				equals: grass.
			self
				assert: (interpreter readVariable: 'fertility' agent: nil ifAbsent: [ nil ])
				equals: fertility.
			count := count + 1 ].
	self assert: count equals: 10 * 11
]
