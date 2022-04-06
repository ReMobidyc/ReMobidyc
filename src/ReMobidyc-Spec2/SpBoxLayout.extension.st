Extension { #name : #SpBoxLayout }

{ #category : #'*ReMobidyc-Spec2' }
SpBoxLayout >> removeAll [

	"Remove all presenters added to this layout."

	children ifEmpty: [ ^ self ].
	children keysDo: [ :each | 
		each isPresenter ifTrue: [ 
			each withAdapterDo: [ :anAdapter | anAdapter unsubscribe ] ] ].
	children removeAll.
	self withAdapterDo: [ :anAdapter | anAdapter removeAll ]
]
