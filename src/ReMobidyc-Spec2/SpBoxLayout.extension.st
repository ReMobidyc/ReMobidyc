Extension { #name : #SpBoxLayout }

{ #category : #'*ReMobidyc-Spec2' }
SpBoxLayout >> addButton: aSymbol dropdownButton: anotherSymbol [

	self
		add: aSymbol width: SpAbstractWidgetPresenter buttonHeight;
		add: anotherSymbol withConstraints: [ :c | 
			c
				width: 6;
				padding: -6;
				fill: false;
				expand: false ];
		add: ' ' width: 4
]

{ #category : #'*ReMobidyc-Spec2' }
SpBoxLayout >> addSpace [

	self add: ' ' width: 4
]

{ #category : #'*ReMobidyc-Spec2' }
SpBoxLayout >> removeAll [
	"Remove all presenters added to this layout."

	children ifEmpty: [ ^ self ].
	children keysDo: [ :each | 
		each withAdapterDo: [ :anAdapter | anAdapter unsubscribe ] ].
	children removeAll.
	self withAdapterDo: [ :anAdapter | anAdapter removeAll ]
]
