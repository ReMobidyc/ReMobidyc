Class {
	#name : #RMDSourcePresenterStyler,
	#superclass : #SHTextStyler,
	#instVars : [
		'presenter'
	],
	#category : #'ReMobidyc-Spec2-Utilities'
}

{ #category : #'instance creation' }
RMDSourcePresenterStyler class >> for: aSpPresenter [

	^ self new
		  presenter: aSpPresenter;
		  yourself
]

{ #category : #accessing }
RMDSourcePresenterStyler >> presenter [

	^ presenter
]

{ #category : #accessing }
RMDSourcePresenterStyler >> presenter: aPresenter [

	presenter := aPresenter
]

{ #category : #private }
RMDSourcePresenterStyler >> privateStyle: aText [

	(presenter respondsTo: #text) ifFalse: [ ^ aText ].
	(presenter respondsTo: #highlightedTextFrom:) ifFalse: [ ^ aText ].
	(presenter respondsTo: #syntaxNode) ifFalse: [ ^ aText ].
	^ text := presenter highlightedTextFrom: presenter syntaxNode
]
