Trait {
	#name : #TRMDIndividualObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDIndividualObservatory >> agentDefinitionDo: aBlock [

	self interpreterDo: [ :interpreter | 
		interpreter simulationModel
			animatDefinitionAt: self currentAnimat
			ifPresent: aBlock ]
]
