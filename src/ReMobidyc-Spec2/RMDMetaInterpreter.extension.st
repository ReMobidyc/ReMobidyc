Extension { #name : #RMDMetaInterpreter }

{ #category : #'*ReMobidyc-Spec2' }
RMDMetaInterpreter >> openInExperimentarium [

	^ (RMDExperimentarium interpreter: self) open
]
