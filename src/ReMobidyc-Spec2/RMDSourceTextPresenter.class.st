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

	| nodes sections newText |
	nodes := Set new: highlights size + 5.
	sections := OrderedCollection new: highlights size + 5.
	highlights do: [ :highlight | 
		highlight isInterval
			ifTrue: [ sections add: highlight ]
			ifFalse: [ nodes add: highlight ] ].
	newText := syntaxNode
		           ifNotNil: [ 
			           (String streamContents: [ :stream | 
				            syntaxNode
					            printOn: stream
					            ifIncludedIn: nodes
					            addSectionTo: sections ]) asText ]
		           ifNil: [ text asText ].
	sections do: [ :section | 
		newText
			makeColor: highlightColor
			from: section first
			to: section last ].
	^ newText
]

{ #category : #initialization }
RMDSourceTextPresenter >> initialize [

	super initialize.
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
	self text: (aRMDSyntaxNode isString
			 ifTrue: [ aRMDSyntaxNode ]
			 ifFalse: [ aRMDSyntaxNode printString ])
]

{ #category : #api }
RMDSourceTextPresenter >> text: aString [

	parser ifNil: [ syntaxNode := nil ] ifNotNil: [ 
		| node |
		node := parser end parse: aString.
		node isPetit2Failure
			ifTrue: [ 
				self beError.
				syntaxNode := nil ]
			ifFalse: [ self basicSyntaxNode: node ] ].
	self updateHighlights: aString.
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
				on: RMDUnresolvedReferenceError
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
