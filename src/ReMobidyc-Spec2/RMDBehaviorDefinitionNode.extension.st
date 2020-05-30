Extension { #name : #RMDBehaviorDefinitionNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDBehaviorDefinitionNode >> asPresenter [
	^ RMDBehaviorDefinitionPresenter on: self
]
