Extension { #name : #RMDPatchInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
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
					patchDefinition allAttributeDeclarations do: [ :attributeDecl | 
							attributeDecl evalIn: self ].
					attributeInitializers do: [ :initializer | 
							initializer evalIn: aRMDInterpreter ] ] ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDPatchInitializerNode >> typecheckIn: aRMDInterpreter [
	aRMDInterpreter
		withContext: aRMDInterpreter newTypecheckContextForPatch
		do: [ attributeInitializers
				do: [ :initializer | initializer typecheckIn: aRMDInterpreter ] ]
]
