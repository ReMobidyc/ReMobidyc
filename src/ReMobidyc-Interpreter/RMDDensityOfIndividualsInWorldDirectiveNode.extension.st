Extension { #name : 'RMDDensityOfIndividualsInWorldDirectiveNode' }

{ #category : '*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInWorldDirectiveNode >> evalIn: aRMDInterpreter [

	| area |
	area := aRMDInterpreter simulationModel worldArea.
	^ area = 0.0
		  ifTrue: [ 0.0 ]
		  ifFalse: [ 
		  (aRMDInterpreter numberOfIndividualsInWorld: animatName) / area ]
]

{ #category : '*ReMobidyc-Interpreter' }
RMDDensityOfIndividualsInWorldDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		stagesOf: animatName
		do: [ :animatDef |
			^ type := RMDType unit: aRMDInterpreter patchLengthUnit ** -2 ].
	^ RMDUndefinedAnimatError on: animatName
]
