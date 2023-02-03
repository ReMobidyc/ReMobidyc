Extension { #name : #RMDInterpreter }

{ #category : #'*ReMobidyc-Spec2' }
RMDInterpreter >> openInObservatory [

	^ (RMDObservatory interpreter: self) open
]
