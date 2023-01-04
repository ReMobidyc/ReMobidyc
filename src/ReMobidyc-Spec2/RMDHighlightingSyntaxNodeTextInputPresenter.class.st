Class {
	#name : #RMDHighlightingSyntaxNodeTextInputPresenter,
	#superclass : #RMDSyntaxNodeTextInputPresenter,
	#instVars : [
		'#highlightColor => ObservableSlot',
		'#simulationModelBlock',
		'#subjectBlock',
		'#objectBlock',
		'#expectedType'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> expectedType [

	^ expectedType
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> expectedType: aRMDType [

	expectedType := aRMDType
]

{ #category : #initialization }
RMDHighlightingSyntaxNodeTextInputPresenter >> initialize [

	super initialize.
	highlightColor := Color red darker.
	expectedType := RMDType any
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : #private }
RMDHighlightingSyntaxNodeTextInputPresenter >> prettyPrint: aRMDSyntaxNode [

	| errorNodes sections newText |
	errorNodes := OrderedCollection new: 10.
	[ 
	[ 
	[ 
	expectedType unify: (self typechecker
			 typecheck: aRMDSyntaxNode
			 subject: self subject
			 object: self object) ]
		on: RMDTypeUnificationError
		do: [ :ex | errorNodes add: aRMDSyntaxNode ] ]
		on: RMDTypeError
		do: [ :ex | 
			errorNodes add: ex node.
			ex resume: ex type2 ] ]
		on: RMDUnresolvedReferenceError
		do: [ :ex | 
			errorNodes add: ex node.
			ex resume: RMDType any ].
	sections := OrderedCollection new: errorNodes size.
	newText := (String streamContents: [ :stream | 
		            aRMDSyntaxNode ifNotNil: [ 
			            aRMDSyntaxNode
				            printOn: stream
				            ifIncludedIn: errorNodes
				            addSectionTo: sections ] ]) asText.
	sections do: [ :section | 
		newText
			makeColor: highlightColor
			from: section first
			to: section last ].
	^ newText
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> simulationModel [

	^ simulationModelBlock value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> simulationModelBlock: aBlock [
	simulationModelBlock := aBlock
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> subjectBlock: aBlock [

	subjectBlock := aBlock
]

{ #category : #api }
RMDHighlightingSyntaxNodeTextInputPresenter >> syntaxNode: aRMDSyntaxNode [

	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ 
			aRMDSyntaxNode hasPlaceholder
				ifTrue: [ self beWarning ]
				ifFalse: [ self beOk ].
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	text := self prettyPrint: aRMDSyntaxNode
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> typechecker [

	^ self simulationModel
		  ifNotNil: #typechecker
		  ifNil: [ RMDTypechecker new ]
]
