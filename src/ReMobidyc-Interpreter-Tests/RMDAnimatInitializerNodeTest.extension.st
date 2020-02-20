Extension { #name : #RMDAnimatInitializerNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDAnimatInitializerNodeTest >> testEvalIn [
	| goatDef goatInitializer minBody maxBody age count |
	goatDef := parser animatDefinition
		parse:
			'Goat is Animat with
	body [kcal]
	age [day].'.
	goatInitializer := parser animatInitializer
		parse:
			'10 Goat with
			body = uniform 1000 [kcal] to 5000 [ kcal ]
			age = 0 [day]'.
	10 timesRepeat: [ interpreter allocateAnimat: goatDef ].
	interpreter
		individualsOf: goatDef
		do: [ :goat | 
			interpreter setInitializerContextWithSubject: goat species: goatDef.
			goatInitializer evalIn: interpreter ].
	self assert: interpreter time closeTo: 0.0.
	minBody := 'kcal' asRMDUnit toSI: 1000.
	maxBody := 'kcal' asRMDUnit toSI: 5000.
	age := 0.0.
	count := 0.
	interpreter
		individualsOf: goatDef
		do: [ :cell | 
			interpreter
				setActionContextWithIndividual: cell
				species: goatDef
				propertyBindMap: goatDef defaultPropertyBinds.
			self
				assert:
					((interpreter readVariable: 'body' agent: nil ifAbsent: [ nil ])
						between: minBody
						and: maxBody).
			self
				assert: (interpreter readVariable: 'age' agent: nil ifAbsent: [ nil ])
				closeTo: age.
			count := count + 1 ].
	self assert: count equals: 10
]
