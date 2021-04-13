Class {
	#name : #RMDHighlightingSyntaxNodeTextInputPresenter,
	#superclass : #RMDSyntaxNodeTextInputPresenter,
	#instVars : [
		'#highlights => SpObservableSlot',
		'#highlightColor => SpObservableSlot'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #private }
RMDHighlightingSyntaxNodeTextInputPresenter >> highlightedTextFrom: aRMDSyntaxNode [
	| sections newText |
	sections := OrderedCollection new: 10.
	newText := (String
		streamContents: [ :stream | 
			aRMDSyntaxNode
				printOn: stream
				ifIncludedIn: highlights asSet
				addSectionTo: sections ]) asText.
	sections
		do:
			[ :section | newText makeColor: highlightColor from: section first to: section last ].
	^ newText
]

{ #category : #api }
RMDHighlightingSyntaxNodeTextInputPresenter >> highlights: aCollectionOfRMDSyntaxNode [
	highlights := aCollectionOfRMDSyntaxNode.
	syntaxNode ifNotNil: [ text := self highlightedTextFrom: syntaxNode ]
]

{ #category : #initialization }
RMDHighlightingSyntaxNodeTextInputPresenter >> initialize [
	super initialize.
	highlightColor := Color red darker.
	highlights := Array new
]

{ #category : #api }
RMDHighlightingSyntaxNodeTextInputPresenter >> syntaxNode: aRMDSyntaxNode [
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	text := self highlightedTextFrom: aRMDSyntaxNode
]
