Extension { #name : #RMDVariabilityNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariabilityNode >> metaEvalIn: aRMDMetaInterpreter [

	self dictionariesDo: [ :metaparameters | 
		aRMDMetaInterpreter
			addSimulationModel:
				(aRMDMetaInterpreter simulationModel 
					 instantiateWithMetaParameters: metaparameters)
			multiplicity: multiplicity
			randomSeed: randomSeed ]
]
