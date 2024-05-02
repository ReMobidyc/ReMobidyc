Extension { #name : 'RubAbstractTextArea' }

{ #category : '*ReMobidyc-Spec2' }
RubAbstractTextArea >> updateTextWith: aStringOrText [
	self
		handleEdit: [ self
				beEditableWhile: [ | s |
					s := self validateTextFrom: aStringOrText.
					(s = self text and: [ s runs = self text runs ])
						ifFalse: [ self selectAll.
							self editor replaceSelectionWith: s.
							self deselect ] ] ]
]
