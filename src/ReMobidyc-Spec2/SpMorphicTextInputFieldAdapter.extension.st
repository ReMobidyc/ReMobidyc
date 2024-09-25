Extension { #name : 'SpMorphicTextInputFieldAdapter' }

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTextInputFieldAdapter >> editor [

	^ widget textArea editor
]

{ #category : '*ReMobidyc-Spec2' }
SpMorphicTextInputFieldAdapter >> pasteText [

	self editor paste
]
