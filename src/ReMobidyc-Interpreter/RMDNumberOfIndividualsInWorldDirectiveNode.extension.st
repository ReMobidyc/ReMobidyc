Extension { #name : #RMDNumberOfIndividualsInWorldDirectiveNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInWorldDirectiveNode >> evalIn: aRMDInterpreter [

	^ aRMDInterpreter numberOfIndividualsInWorld: animatName
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDNumberOfIndividualsInWorldDirectiveNode >> typecheckIn: aRMDInterpreter [

	aRMDInterpreter simulationModel
		animatDefinitionAt: animatName
		ifAbsent: [ ^ RMDUndefinedAnimatError on: animatName ].
	^ RMDType noDimension
]
