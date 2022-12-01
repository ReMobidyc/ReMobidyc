Class {
	#name : #RMDSourceTemplate,
	#superclass : #Object,
	#instVars : [
		'name',
		'sourceText',
		'description'
	],
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #'instance creation' }
RMDSourceTemplate class >> name: nameString description: descriptionString sourceText: sourceTextString [

	^ self new
		  name: nameString;
		  description: descriptionString;
		  sourceText: sourceTextString;
		  yourself
]

{ #category : #menu }
RMDSourceTemplate >> addToMenu: aSpMenuPresenter for: aSpAbstractTextPresenter [

	aSpMenuPresenter addItem: [ :item | 
		item
			name: self name;
			description: self description;
			action: [ 
				Clipboard clipboardText: self sourceText.
				aSpAbstractTextPresenter doTextPaste ] ]
]

{ #category : #accessing }
RMDSourceTemplate >> description [

	^ description
]

{ #category : #accessing }
RMDSourceTemplate >> description: aString [

	description := aString
]

{ #category : #accessing }
RMDSourceTemplate >> name [

	^ name
]

{ #category : #accessing }
RMDSourceTemplate >> name: aString [

	name := aString
]

{ #category : #accessing }
RMDSourceTemplate >> sourceText [

	^ sourceText
]

{ #category : #accessing }
RMDSourceTemplate >> sourceText: aString [

	sourceText := aString
]
