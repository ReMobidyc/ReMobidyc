Extension { #name : #RMDMetaInterpreter }

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInExperimentarium [

	^ (RMDExperimentarium interpreter: self) open
]

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInPopulationTabular [

	^ (RMDPopulationTabular on: self) open
]
