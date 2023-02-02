Trait {
	#name : #TRMDAnimatObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDAnimatObservatory >> agentDefinitionDo: aBlock [

	self interpreterDo: [ :interpreter | 
		interpreter simulationModel
			animatDefinitionAt: self animat
			ifPresent: aBlock ]
]
