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
	interpreter memory allocatePatches: patchDef x: 10 y: 11.
	interpreter individualsOf: patchDef do: [ :patch | 
		interpreter
			withInitializerContextWithSubject: patch
			definition: patchDef
			do: [ patchInitializer evalIn: interpreter ] ].
	self assert: interpreter time closeTo: 0.0.
	grass := 'kcal' asRMDUnit toSI: 1000.
	fertility := 'kcal' asRMDUnit toSI: 1100.
	count := 0.
	interpreter individualsOf: patchDef do: [ :patch | 
		interpreter
			withActionContextWithSubject: patch
			definition: patchDef
			do: [ 
				self
					assert:
					(interpreter readVariable: 'grass' agent: nil ifAbsent: [ nil ])
					equals: grass.
				self
					assert:
					(interpreter
						 readVariable: 'fertility'
						 agent: nil
						 ifAbsent: [ nil ])
					equals: fertility.
				count := count + 1 ] ].
	self assert: count equals: 10 * 11
]
