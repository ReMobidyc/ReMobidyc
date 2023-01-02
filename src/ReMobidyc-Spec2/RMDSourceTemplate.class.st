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
RMDSourceTemplate class >> fromJsonObject: aDictionaryOrArray [

	^ self
		  name: (aDictionaryOrArray at: 'name' ifAbsent: [ 'N/A' ])
		  description:
		  (aDictionaryOrArray at: 'description' ifAbsent: [ '' ])
		  sourceText: (aDictionaryOrArray at: 'sourceText' ifAbsent: [ '' ])
]

{ #category : #'instance creation' }
RMDSourceTemplate class >> fromJsonStream: aString [

	^ self fromJsonObject: ([ STONJSON fromStream: aString ]
			   on: Error
			   do: [ :ex | Array new ])
]

{ #category : #'instance creation' }
RMDSourceTemplate class >> fromJsonString: aString [

	^ self fromJsonObject: ([ STONJSON fromString: aString ]
			   on: Error
			   do: [ :ex | Array new ])
]

{ #category : #'instance creation' }
RMDSourceTemplate class >> name: nameString description: descriptionString sourceText: sourceTextString [

	^ self basicNew
		  name: nameString;
		  description: descriptionString;
		  sourceText: sourceTextString;
		  yourself
]

{ #category : #'instance creation' }
RMDSourceTemplate class >> new [

	^ self name: '' description: '' sourceText: ''
]

{ #category : #comparing }
RMDSourceTemplate >> = anObject [

	^ self class = anObject class and: [ 
		  name = anObject name and: [ 
			  description = anObject description and: [ 
				  sourceText = anObject sourceText ] ] ]
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

{ #category : #converting }
RMDSourceTemplate >> asJsonObject [

	^ OrderedDictionary new
		  at: 'name' put: name;
		  at: 'sourceText' put: sourceText;
		  at: 'description' put: description;
		  yourself
]

{ #category : #accessing }
RMDSourceTemplate >> description [

	^ description
]

{ #category : #accessing }
RMDSourceTemplate >> description: aString [

	description := aString
]

{ #category : #comparing }
RMDSourceTemplate >> hash [

	^ ((self class hash bitXor: name hash) bitXor: description hash) 
		  bitXor: sourceText hash
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
