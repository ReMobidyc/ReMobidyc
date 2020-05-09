Extension { #name : #RMDCellInitializerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDCellInitializerNode >> asPresenter [
	^ RMDCellInitializerEditor on: self
]
