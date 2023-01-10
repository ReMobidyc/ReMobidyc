Class {
	#name : #RMDMetadataPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'metadata',
		'nameField',
		'dateField',
		'descriptionText',
		'authorsField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDMetadataPresenter class >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: (SpBoxLayout newVertical
				   add:
					   (SpBoxLayout newHorizontal add: 'model name' expand: false)
				   height: self inputTextHeight;
				   add: (SpBoxLayout newHorizontal add: 'author' expand: false)
				   height: self inputTextHeight;
				   add: (SpBoxLayout newHorizontal add: 'date' expand: false)
				   height: self inputTextHeight;
				   add:
					   (SpBoxLayout newHorizontal add: 'description' expand: false)
				   height: self inputTextHeight;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newVertical
				   add: (SpBoxLayout newHorizontal add: #nameField expand: true)
				   height: self inputTextHeight;
				   add: (SpBoxLayout newHorizontal add: #authorsField expand: true)
				   height: self inputTextHeight;
				   add: (SpBoxLayout newHorizontal add: #dateField expand: true)
				   height: self inputTextHeight;
				   add:
					   (SpBoxLayout newHorizontal add: #descriptionText expand: true)
				   expand: true;
				   yourself)
		  expand: true;
		  yourself
]

{ #category : #'instance creation' }
RMDMetadataPresenter class >> on: aRMDMetadata [

	^ self new
		  metadata: aRMDMetadata;
		  yourself
]

{ #category : #initialization }
RMDMetadataPresenter >> initializePresenters [

	super initializePresenters.
	nameField := self newTextInput
		             whenTextChangedDo: [ :text | 
			             metadata ifNotNil: [ 
					             metadata
						             name: text;
						             date: DateAndTime now.
					             self metadataChanged ] ];
		             yourself.
	authorsField := self newTextInput
		                whenTextChangedDo: [ :text | 
			                metadata ifNotNil: [ 
					                metadata
						                authors: ((text substrings: ',') collect: #trim);
						                date: DateAndTime now.
					                self metadataChanged ] ];
		                yourself.

	dateField := self newTextInput
		             disable;
		             yourself.
	descriptionText := self newText
		                   whenTextChangedDo: [ :text | 
			                   metadata ifNotNil: [ 
					                   metadata
						                   description: text;
						                   date: DateAndTime now.
					                   self metadataChanged ] ];
		                   yourself
]

{ #category : #accessing }
RMDMetadataPresenter >> metadata [
	^ metadata
]

{ #category : #accessing }
RMDMetadataPresenter >> metadata: aRMDMetadata [

	metadata := aRMDMetadata.
	self metadataChanged
]

{ #category : #updating }
RMDMetadataPresenter >> metadataChanged [

	metadata ifNotNil: [ 
		nameField text: metadata name.
		authorsField text: (', ' join: metadata authors).
		dateField text: metadata dateString.
		descriptionText text: metadata description ]
]

{ #category : #enumerating }
RMDMetadataPresenter >> whenNameChangedDo: aBlock [

	nameField whenTextChangedDo: aBlock
]
