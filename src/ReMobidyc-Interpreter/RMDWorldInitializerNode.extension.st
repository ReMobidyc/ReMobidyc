Extension { #name : #RMDWorldInitializerNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> evalIn: aRMDInterpreter [

	| worldDefinition world |
	worldDefinition := aRMDInterpreter simulationModel worldDefinition.
	world := aRMDInterpreter memory allocateWorld: worldDefinition.
	aRMDInterpreter
		withInitializerContextWithSubject: world
		definition: worldDefinition
		do: [ 
			worldDefinition evalIn: aRMDInterpreter.
			super evalIn: aRMDInterpreter ]
]

{ #category : #'*ReMobidyc-Interpreter' }
RMDWorldInitializerNode >> typecheckIn: aRMDInterpreter [

	^ aRMDInterpreter
		  withSubjectDefinition: aRMDInterpreter world
		  do: [ super typecheckIn: aRMDInterpreter ]
]
