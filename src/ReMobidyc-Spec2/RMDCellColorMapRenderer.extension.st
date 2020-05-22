Extension { #name : #RMDCellColorMapRenderer }

{ #category : #'*ReMobidyc-Spec2' }
RMDCellColorMapRenderer >> asPresenter [
	^ RMDCellColorMapRendererEditor on: self
]

{ #category : #'*ReMobidyc-Spec2' }
RMDCellColorMapRenderer >> minAndColorEditorsDo: aBlock [
	minAndColors
		do: [ :assoc | aBlock value: (RMDCellColorMapEntryEditor on: assoc) ]
]
