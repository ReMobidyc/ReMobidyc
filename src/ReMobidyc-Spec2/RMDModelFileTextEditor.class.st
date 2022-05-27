Class {
	#name : #RMDModelFileTextEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'fileList',
		'sourceText'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDModelFileTextEditor class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  add: #fileList;
		  add: #sourceText;
		  positionOfSlider: 0.4;
		  yourself
]

{ #category : #parsers }
RMDModelFileTextEditor >> freeTextParser [

	^ #any asPParser star flatten end
]

{ #category : #initialization }
RMDModelFileTextEditor >> initializePresenters [

	super initializePresenters.
	fileList := self newList.
	sourceText := self newSourceWith: self freeTextParser
]
