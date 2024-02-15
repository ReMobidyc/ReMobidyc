Class {
	#name : #RMDMetaParameterSetSequencePresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'placeholdersLabel',
		'tuplesField'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDMetaParameterSetSequencePresenter class >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  vAlignCenter;
		  add: #placeholdersLabel expand: false;
		  add: ' -> ' expand: false;
		  expand: false;
		  add: #tuplesField;
		  yourself
]

{ #category : #initialization }
RMDMetaParameterSetSequencePresenter >> initializePresenters [

	super initializePresenters.
	placeholdersLabel := self newLabel
		                     label: '-';
		                     yourself.
	tuplesField := self newSyntaxNodeTextInput
		               parser: RMDGrammar current tupleSequence;
		               display: [ :syntaxNode | 
			               ',' , String cr join:
					               (syntaxNode collect: [ :tuple | 
							                '('
							                , (', ' join: (tuple collect: #printString))
							                , ')' ]) ];
		               whenLastValidSyntaxNodeChangedDo: [ 
			               self tuplesChanged ];
		               yourself
]

{ #category : #accessing }
RMDMetaParameterSetSequencePresenter >> nodeChanged [

	node ifNotNil: [ 
		placeholdersLabel label:
			(', ' join: (node placeholders collect: #printString)).
		tuplesField syntaxNode: node literalTuples ]
]

{ #category : #accessing }
RMDMetaParameterSetSequencePresenter >> preferredHeight [

	^ self class inputTextHeight * 5
]

{ #category : #updating }
RMDMetaParameterSetSequencePresenter >> tuplesChanged [

	node literalTuples: tuplesField lastValidSyntaxNode
]
