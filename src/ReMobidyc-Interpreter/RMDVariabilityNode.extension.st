Extension { #name : #RMDVariabilityNode }

{ #category : #'*ReMobidyc-Interpreter' }
RMDVariabilityNode >> metaEvalIn: aRMDMetaInterpreter [

	self dictionariesDo: [ :metaparameters | 
		aRMDMetaInterpreter
			addInterpreterWithMetaparameters: metaparameters
			multiplicity: multiplicity
			randomSeed: randomSeed ]
]
