Extension { #name : #RMDActionIdentifierNode }

{ #category : #'*ReMobidyc-Spec2' }
RMDActionIdentifierNode >> selectRepositoryList: aSpListPresenter [
	aSpListPresenter
		selectItem:
			(aSpListPresenter items
				detect: [ :repository | repository includesActionIdentifier: self ]
				ifNone: [ nil ])
]
