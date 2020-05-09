Extension { #name : #RMDPropertyInitializerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDPropertyInitializerNode >> asPresenter [
	^ RMDPropertyInitializerEditor on: self
]
