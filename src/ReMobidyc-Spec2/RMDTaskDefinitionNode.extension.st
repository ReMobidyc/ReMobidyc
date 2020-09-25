Extension { #name : #RMDTaskDefinitionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDTaskDefinitionNode >> asPresenter [
	^ RMDTaskDefinitionPresenter on: self
]
