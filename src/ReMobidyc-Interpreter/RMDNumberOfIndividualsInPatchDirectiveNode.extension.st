Extension { #name : 'RMDNumberOfIndividualsInPatchDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInPatchDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter numberOfIndividualsInPatch: animatName
]

{ #category : '*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInPatchDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		stagesOf: animatName
		do: [ :animatDef | ^ type := RMDType noDimension ].
	^ RMDUndefinedAnimatError on: animatName
]
