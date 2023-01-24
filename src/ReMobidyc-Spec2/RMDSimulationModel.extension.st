Extension { #name : #RMDSimulationModel }

{ #category : #'*ReMobidyc-Spec2' }
RMDSimulationModel >> openInModeler [

	^ (RMDSimulationModeler on: self)
		  open;
		  yourself
]
