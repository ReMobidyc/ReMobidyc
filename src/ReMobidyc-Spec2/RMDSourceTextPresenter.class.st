Class {
	#name : #RMDSourceTextPresenter,
	#superclass : #SpTextPresenter,
	#traits : 'TRMDPresenter + TRMDTemplateMenu',
	#classTraits : 'TRMDPresenter classTrait + TRMDTemplateMenu classTrait',
	#instVars : [
		'#syntaxNode => ObservableSlot',
		'#lastValidSyntaxNode => ObservableSlot',
		'#highlights => ObservableSlot',
		'#highlightColor => ObservableSlot',
		'#autoTypecheckingEnabled => ObservableSlot',
		'#parser',
		'#simulationModelBlock',
		'#subjectBlock',
		'#objectBlock'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDSourceTextPresenter >> acceptSyntaxNode: aRMDSyntaxNode [

	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ 
			self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	self text: aRMDSyntaxNode printString
]

{ #category : #api }
RMDSourceTextPresenter >> autoTypecheckingEnabled [

	^ autoTypecheckingEnabled
]

{ #category : #api }
RMDSourceTextPresenter >> autoTypecheckingEnabled: aBoolean [

	autoTypecheckingEnabled := aBoolean ~= false
]

{ #category : #private }
RMDSourceTextPresenter >> basicSyntaxNode: aRMDSyntaxNode [
	syntaxNode == aRMDSyntaxNode ifTrue: [ ^ self ].
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ 
			self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].

]

{ #category : #api }
RMDSourceTextPresenter >> disableAutoTypechecking [
	self autoTypecheckingEnabled: false
]

{ #category : #api }
RMDSourceTextPresenter >> enableAutoTypechecking [
	self autoTypecheckingEnabled: true
]

{ #category : #accessing }
RMDSourceTextPresenter >> highlightColor [

	^ highlightColor
]

{ #category : #accessing }
RMDSourceTextPresenter >> highlightColor: aColor [

	highlightColor := aColor
]

{ #category : #api }
RMDSourceTextPresenter >> highlightedText [

	^ syntaxNode
		  ifNotNil: [ syntaxNode asTextWithHighlights: highlights ]
		  ifNil: [ Text new ]
]

{ #category : #api }
RMDSourceTextPresenter >> highlights: aCollectionOfRMDSyntaxNode [

	| t |
	highlights := aCollectionOfRMDSyntaxNode.
	t := text.
	text := ''.
	super text: t
]

{ #category : #initialization }
RMDSourceTextPresenter >> initialize [

	super initialize.
	autoTypecheckingEnabled := true.
	highlightColor := Color red darker.
	highlights := Array new.
	self whenBuiltDo: [ 
		self withAdapterDo: [ :a | 
			a widgetDo: [ :w | 
				| t |
				t := w textArea.
				t beForReMobidyc.
				t withDecoratorNamed: #shoutStyler.
				w shoutStyler styler: (RMDSourcePresenterStyler for: self).
				w setText: self highlightedText ] ] ].
	self whenSubmitDo: [ :t | self prettyPrint ]
]

{ #category : #api }
RMDSourceTextPresenter >> lastValidSyntaxNode [
	^ lastValidSyntaxNode
]

{ #category : #accessing }
RMDSourceTextPresenter >> object [

	^ objectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDSourceTextPresenter >> objectBlock: aBlock [

	objectBlock := aBlock
]

{ #category : #api }
RMDSourceTextPresenter >> parser [
	^ parser
]

{ #category : #api }
RMDSourceTextPresenter >> parser: aPP2Node [
	parser := aPP2Node
]

{ #category : #api }
RMDSourceTextPresenter >> prettyPrint [

	self syntaxNode: self lastValidSyntaxNode
]

{ #category : #accessing }
RMDSourceTextPresenter >> simulationModel [
	^ simulationModelBlock value
]

{ #category : #accessing }
RMDSourceTextPresenter >> simulationModelBlock: aBlock [

	simulationModelBlock := aBlock
]

{ #category : #accessing }
RMDSourceTextPresenter >> subject [

	^ subjectBlock ifNotNil: #value
]

{ #category : #accessing }
RMDSourceTextPresenter >> subjectBlock: aBlock [

	subjectBlock := aBlock
]

{ #category : #api }
RMDSourceTextPresenter >> syntaxNode [
	^ syntaxNode
]

{ #category : #api }
RMDSourceTextPresenter >> syntaxNode: aRMDSyntaxNode [

	syntaxNode == aRMDSyntaxNode ifTrue: [ ^ self ].
	self basicSyntaxNode: aRMDSyntaxNode.
	self text: (aRMDSyntaxNode ifNil: [ '' ] ifNotNil: [ 
			 aRMDSyntaxNode isString
				 ifTrue: [ aRMDSyntaxNode ]
				 ifFalse: [ aRMDSyntaxNode printString ] ])
]

{ #category : #api }
RMDSourceTextPresenter >> text: aString [

	text = aString ifTrue: [ ^ self ].
	parser ifNil: [ syntaxNode := nil ] ifNotNil: [ 
		| node |
		node := parser end parse: aString.
		node isPetit2Failure
			ifTrue: [ 
				self beError.
				syntaxNode := nil ]
			ifFalse: [ self basicSyntaxNode: node ] ].
	autoTypecheckingEnabled ifTrue: [ self updateHighlights: aString ].
	^ super text: aString
]

{ #category : #accessing }
RMDSourceTextPresenter >> typechecker [

	^ self simulationModel
		  ifNotNil: #typechecker
		  ifNil: [ RMDTypechecker new ]
]

{ #category : #private }
RMDSourceTextPresenter >> updateHighlights: aString [

	| errorNodes |
	errorNodes := OrderedCollection new: 10.
	syntaxNode
		ifNotNil: [ 
			[ 
			[ self typechecker typecheck: syntaxNode subject: self subject object: self object]
				on: RMDTypeError
				do: [ :ex | 
					errorNodes add: ex node.
					ex resume: ex type2 ] ]
				on: RMDError
				do: [ :ex | 
					errorNodes add: ex node.
					ex resume: RMDType any ] ]
		ifNil: [ 
			parser ifNotNil: [ 
				| node |
				node := parser end parse: aString.
				node isPetit2Failure ifTrue: [ 
					errorNodes add: ((node position max: 1) to: aString size) ] ] ].
	highlights := errorNodes
]

{ #category : #'api-events' }
RMDSourceTextPresenter >> whenAutoTypecheckingEnabledChangedDo: aBlock [
	self property: #autoTypecheckingEnabled whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDSourceTextPresenter >> whenLastValidSyntaxNodeChangedDo: aBlock [
	self property: #lastValidSyntaxNode whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDSourceTextPresenter >> whenParserChangedDo: aBlock [
	self property: #parser whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDSourceTextPresenter >> whenSyntaxNodeChangedDo: aBlock [
	self property: #syntaxNode whenChangedDo: aBlock
]
