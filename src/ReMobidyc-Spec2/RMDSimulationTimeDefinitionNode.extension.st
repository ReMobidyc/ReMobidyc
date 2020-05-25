Extension { #name : #RMDSimulationTimeDefinitionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDSimulationTimeDefinitionNode >> asPresenter [
	^ RMDSimulationTimeDefinitionPresenter on: self
]
