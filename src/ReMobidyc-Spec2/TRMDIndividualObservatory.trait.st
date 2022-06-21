Trait {
	#name : #TRMDIndividualObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDIndividualObservatory >> agentDefinitionDo: aBlock [
	self
		interpreterDo: [ :interpreter | interpreter animatDefinitionAt: self currentAnimat ifPresent: aBlock ]
]
