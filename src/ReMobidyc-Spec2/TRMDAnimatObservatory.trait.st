Trait {
	#name : #TRMDAnimatObservatory,
	#category : #'ReMobidyc-Spec2-Traits'
}

{ #category : #enumerating }
TRMDAnimatObservatory >> speciesDefinitionDo: aBlock [
	self
		interpreterDo: [ :interpreter | interpreter animatDefinitionAt: self animat ifPresent: aBlock ]
]
