Extension { #name : #RMDInterpreter }

{ #category : #'*ReMobidyc-Spec2' }
RMDInterpreter >> asPresenter [
	^ RMDInterpreterPresenter on: self
]
