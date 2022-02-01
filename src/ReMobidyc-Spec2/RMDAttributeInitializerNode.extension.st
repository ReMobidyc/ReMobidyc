Extension { #name : #RMDAttributeInitializerNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDAttributeInitializerNode >> asPresenter [
	^ RMDAttributeInitializerPresenter on: self
]
