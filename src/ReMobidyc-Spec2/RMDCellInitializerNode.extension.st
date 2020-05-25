Extension { #name : #RMDCellInitializerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDCellInitializerNode >> asPresenter [
	^ RMDCellInitializerPresenter on: self
]
