Extension { #name : #RMDAnimatInitializerNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDAnimatInitializerNodeTest >> testEvalIn [
	| goatDef goatInitializer minBody maxBody age count |
	goatDef := parser animatDefinition end
		parse:
			'Goat is Animat with
	body [kcal]
	age [day].'.
	interpreter
		load: goatDef;
		load:
			(parser simulationDefinition end
				parse:
					'Simulation with
	during 10[day] by 0.5[day]
	20x20 of  5[m] Cell.').
	interpreter setupSimulation.
	goatInitializer := parser animatInitializer end
		parse:
			'10 Goat with
			x = uniform 10[m] to 90[m]
			body = uniform 1000 [kcal] to 5000 [ kcal ]
			age = 0 [day]'.
	10 timesRepeat: [ interpreter memory allocateAnimat: goatDef ].
	interpreter
		individualsOf: goatDef
		do: [ :goat | 
			interpreter
				withInitializerContextWithSubject: goat
				species: goatDef
				do: [ goatInitializer evalIn: interpreter ] ].
	self assert: interpreter time closeTo: 0.0.
	minBody := 'kcal' asRMDUnit toSI: 1000.
	maxBody := 'kcal' asRMDUnit toSI: 5000.
	age := 0.0.
	count := 0.
	interpreter
		individualsOf: goatDef
		do: [ :goat :lifehistory | 
			interpreter
				withActionContextWithIndividual: lifehistory
				species: goatDef
				do: [ self
						assert:
							((interpreter readVariable: 'body' agent: nil ifAbsent: [ nil ])
								between: minBody
								and: maxBody).
					self
						assert: (interpreter readVariable: 'age' agent: nil ifAbsent: [ nil ])
						closeTo: age.
					count := count + 1 ] ].
	self assert: count equals: 10
]
