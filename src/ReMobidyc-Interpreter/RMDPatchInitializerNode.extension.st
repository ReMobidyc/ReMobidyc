Extension { #name : 'RMDPatchInitializerNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDPatchInitializerNode >> evalIn: aRMDInterpreter [

	| patchDefinition |
	patchDefinition := aRMDInterpreter simulationModel patchDefinition.
	aRMDInterpreter memory
		allocatePatches: patchDefinition x: xDivisions y: yDivisions;
		patchesDo: [ :patch |
			aRMDInterpreter
				withInitializerContextWithSubject: patch
				definition: patchDefinition
				do: [
					patchDefinition evalIn: aRMDInterpreter.
					super evalIn: aRMDInterpreter ] ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDPatchInitializerNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter context
		subjectDefinition: aRMDInterpreter simulationModel patchDefinition;
		loadUtilityDefinitions: utilityDefinitions.
	^ super typecheckIn: aRMDInterpreter
]
