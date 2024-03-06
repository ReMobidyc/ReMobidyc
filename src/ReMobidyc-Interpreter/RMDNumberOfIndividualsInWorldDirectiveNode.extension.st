Extension { #name : #RMDNumberOfIndividualsInWorldDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInWorldDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter numberOfIndividualsInWorld: animatName
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInWorldDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		stagesOf: animatName
		do: [ :animatDef | ^ type := RMDType noDimension ].
	^ RMDUndefinedAnimatError on: animatName
]
