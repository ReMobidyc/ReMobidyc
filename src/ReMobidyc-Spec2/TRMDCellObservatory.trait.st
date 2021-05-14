Trait {
	#name : #TRMDCellObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDCellObservatory >> speciesDefinitionDo: aBlock [
	self
		interpreterDo: [ :interpreter | aBlock cull: interpreter cellDefinition ]
]
