Extension { #name : #RMDPropertyInitializerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDPropertyInitializerNode >> asPresenter [
	^ RMDPropertyInitializerPresenter on: self
]
