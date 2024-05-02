Class {
	#name : 'RMDMetaSingleParameterSequencePresenter',
	#superclass : 'RMDSyntaxNodePresenter',
	#instVars : [
		'placeholderLabel',
		'literalsField'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'layout' }
RMDMetaSingleParameterSequencePresenter class >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  vAlignCenter;
		  add: #placeholderLabel expand: false;
		  add: ' -> ' expand: false;
		  add: #literalsField;
		  yourself
]

{ #category : 'initialization' }
RMDMetaSingleParameterSequencePresenter >> initializePresenters [

	super initializePresenters.
	placeholderLabel := self newLabel
		                    label: '-';
		                    yourself.
	literalsField := self newSyntaxNodeTextInput
		                 parser: RMDGrammar current literalSequence;
		                 display: [ :syntaxNode | 
			                 ', ' join: (syntaxNode collect: #printString) ];
		                 whenLastValidSyntaxNodeChangedDo: [ 
			                 self literalsChanged ];
		                 yourself
]

{ #category : 'updating' }
RMDMetaSingleParameterSequencePresenter >> literalsChanged [

	literalsField lastValidSyntaxNode ifNotNil: [ :literals | 
		node literals: literals ]
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequencePresenter >> nodeChanged [

	node ifNotNil: [ 
		placeholderLabel label: node placeholder printString.
		literalsField syntaxNode: node literals ]
]

{ #category : 'accessing' }
RMDMetaSingleParameterSequencePresenter >> preferredHeight [

	^ self class inputTextHeight * 1.5
]
