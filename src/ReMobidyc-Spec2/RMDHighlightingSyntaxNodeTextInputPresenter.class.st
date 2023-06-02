Class {
	#name : #RMDHighlightingSyntaxNodeTextInputPresenter,
	#superclass : #RMDSyntaxNodeTextInputPresenter,
	#instVars : [
		'#highlightColor => ObservableSlot',
		'#simulationModelBlock',
		'#subjectBlock',
		'#objectBlock',
		'#utilitiesBlock',
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

	expectedType := aRMDType.
	self prettyPrint
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

	objectBlock := aBlock.
	self prettyPrint
]

{ #category : #api }
RMDHighlightingSyntaxNodeTextInputPresenter >> prettyPrint [

	syntaxNode ifNotNil: [ text := self prettyPrint: syntaxNode ]
]

{ #category : #private }
RMDHighlightingSyntaxNodeTextInputPresenter >> prettyPrint: aRMDSyntaxNode [

	^ aRMDSyntaxNode
		  ifNotNil: [
			  | errorNodes |
			  errorNodes := OrderedCollection new: 10.
			  [
			  [
			  [
			  expectedType unify: (self typechecker
					   typecheck: aRMDSyntaxNode
					   subject: self subject
					   object: self object
					   utilities: self utilities) ]
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
			  aRMDSyntaxNode asTextWithHighlights: errorNodes ]
		  ifNil: [ Text new ]
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> simulationModel [

	^ simulationModelBlock value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> simulationModelBlock: aBlock [
	simulationModelBlock := aBlock.
	self prettyPrint
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> subjectBlock: aBlock [

	subjectBlock := aBlock.
	self prettyPrint
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

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> utilities [

	^ utilitiesBlock ifNotNil: #value
]

{ #category : #accessing }
RMDHighlightingSyntaxNodeTextInputPresenter >> utilitiesBlock: aBlock [

	utilitiesBlock := aBlock.
	self prettyPrint
]
