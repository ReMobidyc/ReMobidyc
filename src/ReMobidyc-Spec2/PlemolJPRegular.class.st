Class {
	#name : 'PlemolJPRegular',
	#superclass : 'EmbeddedFreeTypeFontDescription',
	#classInstVars : [
		'fontContents'
	],
	#category : 'ReMobidyc-Spec2-Fonts',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Fonts'
}

{ #category : 'testing' }
PlemolJPRegular class >> canBeInstalled [

	^ super canBeInstalled and: [ self fontReference isFile ]
]

{ #category : 'testing' }
PlemolJPRegular class >> fontContents [

	^ (fontContents ifNil: [
		   fontContents := self fontReference binaryReadStreamDo: #contents ])
		  copy
]

{ #category : 'testing' }
PlemolJPRegular class >> fontReference [

	^ FileLocator workingDirectory / 'Fonts' / self originalFileName
]

{ #category : 'testing' }
PlemolJPRegular class >> originalFileName [

	^ 'PlemolJP-Regular.ttf'
]
