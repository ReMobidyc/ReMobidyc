Class {
	#name : #RMDMetadataPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'metadata',
		'nameField',
		'authorField',
		'dateField',
		'descriptionText'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDMetadataPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpGridLayout new
				   columnHomogeneous: false;
				   rowHomogeneous: false;
				   column: 1 expand: false;
				   column: 2 expand: true;
				   row: 1 expand: false;
				   row: 2 expand: false;
				   row: 3 expand: false;
				   add: 'model name' at: 1 @ 1 span: 1 @ 1;
				   add: #nameField at: 2 @ 1 span: 1 @ 1;
				   add: 'author' at: 1 @ 2 span: 1 @ 1;
				   add: #authorField at: 2 @ 2 span: 1 @ 1;
				   add: 'date' at: 1 @ 3 span: 1 @ 1;
				   add: #dateField at: 2 @ 3 span: 1 @ 1;
				   yourself);
		  add: 'description' expand: false;
		  add: #descriptionText expand: true;
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
	authorField := self newTextInput
		               whenTextChangedDo: [ :text | 
			               metadata ifNotNil: [ 
					               metadata
						               author: text;
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
		authorField text: metadata author.
		dateField text: metadata dateString.
		descriptionText text: metadata description ]
]
