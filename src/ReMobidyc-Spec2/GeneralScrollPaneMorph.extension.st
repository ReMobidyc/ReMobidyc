Extension { #name : 'GeneralScrollPaneMorph' }

{ #category : '*ReMobidyc-Spec2' }
GeneralScrollPaneMorph >> vScrollbarInterval [
	"Answer the computed size of the thumb of the vertical scrollbar."

	^ self scrollBounds height asFloat
	  / (self scrollTarget height max: 1) min: 1.0
]

{ #category : '*ReMobidyc-Spec2' }
GeneralScrollPaneMorph >> vScrollbarNeeded [
	"Return whether the vertical scrollbar is needed."

	self vScrollbar showsAlways ifTrue: [ ^ true ].
	self vScrollbar showsNever ifTrue: [ ^ false ].
	self scroller submorphs ifEmpty: [ ^ false ].
	^ self scrollTarget height
	  + (self scrollTarget width > self innerBounds width
			   ifTrue: [ self scrollBarThickness ]
			   ifFalse: [ 0 ]) > self innerBounds height
]
