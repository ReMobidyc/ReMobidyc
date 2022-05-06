Extension { #name : #RMDPatchColorMapRenderer }

{ #category : #'*ReMobidyc-Spec2' }
RMDPatchColorMapRenderer >> asPresenter [
	^ RMDPatchColorMapRendererPresenter on: self
]

{ #category : #'*ReMobidyc-Spec2' }
RMDPatchColorMapRenderer >> minAndColorEditorsDo: aBlock [
	minAndColors
		do: [ :assoc | aBlock value: (RMDPatchColorMapEntryPresenter on: assoc) ]
]
