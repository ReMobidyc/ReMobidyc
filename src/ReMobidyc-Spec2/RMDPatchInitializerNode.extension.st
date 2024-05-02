Extension { #name : 'RMDPatchInitializerNode' }

{ #category : '*ReMobidyc-Spec2' }
RMDPatchInitializerNode >> asPresenter [
	^ RMDPatchInitializerPresenter on: self
]
