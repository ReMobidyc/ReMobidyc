Extension { #name : #RMDSimulationTimeDefinitionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDSimulationTimeDefinitionNode >> asPresenter [
	^ RMDSimulationTimeDefinitionEditor on: self
]
