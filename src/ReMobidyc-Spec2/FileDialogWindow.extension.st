Extension { #name : #FileDialogWindow }

{ #category : #'*ReMobidyc-Spec2' }
FileDialogWindow >> getText [

	^ self openSelectedFile
		  ifNotNil: [ :ref |
		  ref readStreamDo: [ :stream | stream nextLine ] ]
		  ifNil: [ '' ]
]

{ #category : #'*ReMobidyc-Spec2' }
FileDialogWindow >> updateImagePreview [
	"Update the image preview."

	|str form|
	self previewMorph ifNil: [ ^ self ].
	(self isImageFile: self selectedFileName)
		ifFalse: [^self previewMorph
					image: nil
					size: self previewSize].
	str := self openSelectedFile.
	str ifNil: [^self].
	[[str := str wrappedStream.
	form := ImageReadWriter formFromStream: str]
		on: Error do: []]
		ensure: [str close].
	self previewMorph
		image: form
		size: self previewSize
]
