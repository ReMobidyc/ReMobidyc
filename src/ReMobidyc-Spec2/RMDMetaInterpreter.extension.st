Extension { #name : #RMDMetaInterpreter }

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInAttributeTabular [

	^ (RMDStageIndividualsAtTimeTabular on: self) open
]

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInExperimentarium [

	^ (RMDExperimentarium metaInterpreter: self) open
]

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInPopulationTabular [

	^ (RMDPopulationByTimeTabular on: self) open
]
