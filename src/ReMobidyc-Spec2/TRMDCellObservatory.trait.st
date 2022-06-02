Trait {
	#name : #TRMDCellObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDCellObservatory >> agentDefinitionDo: aBlock [
	self
		interpreterDo: [ :interpreter | aBlock cull: interpreter patchDefinition ]
]
