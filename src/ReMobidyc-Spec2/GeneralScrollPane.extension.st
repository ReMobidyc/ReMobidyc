Extension { #name : #GeneralScrollPane }

{ #category : #'*ReMobidyc-Spec2' }
GeneralScrollPane >> vScrollbarNeeded [
	"Return whether the vertical scrollbar is needed."
	
	self vScrollbar showsAlways ifTrue: [^true].
	self vScrollbar showsNever ifTrue: [^false].
	self scroller submorphs ifEmpty: [^false].
	^self scrollTarget height +
		(self scrollTarget width > self innerBounds width
			 ifTrue: [self scrollBarThickness] ifFalse: [0]) >
		self innerBounds height
]
