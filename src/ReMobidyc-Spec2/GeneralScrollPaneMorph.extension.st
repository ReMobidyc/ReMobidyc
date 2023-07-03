Extension { #name : #GeneralScrollPaneMorph }

{ #category : #'*ReMobidyc-Spec2' }
GeneralScrollPaneMorph >> vScrollbarInterval [
	"Answer the computed size of the thumb of the vertical scrollbar."

	^ self scrollBounds height asFloat
	  / (self scrollTarget height max: 1) min: 1.0
]
