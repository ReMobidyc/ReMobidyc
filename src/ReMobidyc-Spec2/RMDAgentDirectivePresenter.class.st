Class {
	#name : #RMDAgentDirectivePresenter,
	#superclass : #RMDExpressionPresenter,
	#instVars : [
		'directiveLabel',
		'agentLabel'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #accessing }
RMDAgentDirectivePresenter >> expressionChanged [

	directiveLabel label: expression directiveName , ' '.
	agentLabel label: expression agentIdentifier.
	super expressionChanged
]

{ #category : #initialization }
RMDAgentDirectivePresenter >> initializePresenters [

	super initializePresenters.
	directiveLabel := self newLabel
		                  displayBold: [ true ];
		                  label: '-';
		                  yourself.
	agentLabel := self newLabel
		              label: '-';
		              yourself
]

{ #category : #layouting }
RMDAgentDirectivePresenter >> layout [

	| newLayout |
	newLayout := SpBoxLayout newHorizontal.
	newLayout add: directiveLabel expand: false.
	newLayout add: agentLabel expand: false.
	^ newLayout
]
