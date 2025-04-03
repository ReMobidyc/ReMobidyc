Extension { #name : 'RMDDensityOfIndividualsInPatchDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInPatchDirectiveNode >> evalIn: aRMDInterpreter [

	| area |
	area := aRMDInterpreter simulationModel patchArea.
	^ area = 0.0
		  ifTrue: [ 0.0 ]
		  ifFalse: [ 
		  (aRMDInterpreter numberOfIndividualsInPatch: animatName) / area ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInPatchDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		stagesOf: animatName
		do: [ :animatDef |
			^ type := RMDType unit: aRMDInterpreter patchLengthUnit ** -2 ].
	^ RMDUndefinedAnimatError on: animatName
]
