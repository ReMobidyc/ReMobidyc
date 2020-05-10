Extension { #name : #RMDSimulationDefinitionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDSimulationDefinitionNode >> asPresenter [
	^ RMDSimulationDefinitionEditor on: self
]
