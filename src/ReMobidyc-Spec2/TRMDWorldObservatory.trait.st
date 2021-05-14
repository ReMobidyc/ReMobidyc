Trait {
	#name : #TRMDWorldObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDWorldObservatory >> speciesDefinitionDo: aBlock [
	self
		interpreterDo: [ :interpreter | aBlock cull: interpreter worldDefinition ]
]
