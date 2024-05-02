Extension { #name : 'RMDSimulationDefinitionNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDSimulationDefinitionNode >> asPresenter [
	^ RMDSimulationDefinitionPresenter on: self
]
