Extension { #name : #RMDCellColorMapRenderer }

{ #category : #'*ReMobidyc-Spec2' }
RMDCellColorMapRenderer >> asPresenter [
	^ RMDCellColorMapRendererPresenter on: self
]

{ #category : #'*ReMobidyc-Spec2' }
RMDCellColorMapRenderer >> minAndColorEditorsDo: aBlock [
	minAndColors
		do: [ :assoc | aBlock value: (RMDCellColorMapEntryPresenter on: assoc) ]
]
