Extension { #name : 'SpWindowPresenter' }

{ #category : '*ReMobidyc-Spec2' }
SpWindowPresenter >> okToClose [
	"Sent to models when a window closing.
	Allows this check to be independent of okToChange."

	^ presenter ifNotNil: #okToClose ifNil: [ super okToClose ]
]
