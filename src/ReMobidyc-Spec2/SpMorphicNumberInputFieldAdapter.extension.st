Extension { #name : 'SpMorphicNumberInputFieldAdapter' }

{ #category : '*ReMobidyc-Spec2' }
SpMorphicNumberInputFieldAdapter >> decreaseValueOf: aTextMorph [
	model isEnabled
		ifTrue: [ aTextMorph setText: (self decreasedValueFrom: aTextMorph getText) ]
]
