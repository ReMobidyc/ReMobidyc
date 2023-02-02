Extension { #name : #RMDPatchInitializerNodeTest }

{ #category : #'*ReMobidyc-Interpreter-Tests' }
RMDPatchInitializerNodeTest >> testEvalIn [

	| patchDef patchInitializer grass fertility count |
	patchDef := parser patchDefinition end parse: 'Patch with
	grass [kcal]
	fertility [kcal].'.
	patchInitializer := parser patchInitializer parse:
		                    '10 x 11 of 2 [m] Patch with
			grass = 1000 [ kcal ]
			fertility = 1100 [kcal]'.
	interpreter simulationModel patchDefinition: patchDef.
	patchInitializer evalIn: interpreter.
	interpreter memory tick.
	self assert: interpreter time closeTo: 0.0.
	grass := 'kcal' asRMDUnit toSI: 1000.
	fertility := 'kcal' asRMDUnit toSI: 1100.
	count := 0.
	interpreter individualsOf: patchDef do: [ :patch | 
		interpreter
			withActionContextWith: RMDActionDefinitionNode template
			subject: patch
			definition: patchDef
			taskHash: 1
			do: [ 
				self assert: (interpreter my: 'grass') equals: grass.
				self assert: (interpreter my: 'fertility') equals: fertility.
				count := count + 1 ] ].
	self assert: count equals: 10 * 11
]
