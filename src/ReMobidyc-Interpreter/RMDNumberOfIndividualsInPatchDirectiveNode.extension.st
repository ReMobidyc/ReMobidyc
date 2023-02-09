Extension { #name : #RMDNumberOfIndividualsInPatchDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInPatchDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter numberOfIndividualsInPatch: animatName
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInPatchDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		animatDefinitionAt: animatName
		ifAbsent: [ ^ RMDUndefinedAnimatError on: animatName ].
	^ RMDType noDimension
]
