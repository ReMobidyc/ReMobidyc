Class {
	#name : #RMDSourceTextPresenter,
	#superclass : #SpTextPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#syntaxNode => ObservableSlot',
		'#lastValidSyntaxNode => ObservableSlot',
		'#highlights => ObservableSlot',
		'#highlightColor => ObservableSlot',
		'#parser'
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
RMDSourceTextPresenter >> highlightedTextFrom: aRMDSyntaxNode [
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
RMDSourceTextPresenter >> highlights [
	^ highlights
]

{ #category : #api }
RMDSourceTextPresenter >> highlights: aCollectionOfRMDSyntaxNode [
	highlights := aCollectionOfRMDSyntaxNode.
	syntaxNode ifNotNil: [ text := self highlightedTextFrom: syntaxNode ]
]

{ #category : #initialization }
RMDSourceTextPresenter >> initialize [
	super initialize.
	highlightColor := Color red darker.
	highlights := Array with: '10000 [kcal]' asRMDExpression
]

{ #category : #api }
RMDSourceTextPresenter >> lastValidSyntaxNode [
	^ lastValidSyntaxNode
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
RMDSourceTextPresenter >> syntaxNode [
	^ syntaxNode
]

{ #category : #api }
RMDSourceTextPresenter >> syntaxNode: aRMDSyntaxNode [

	syntaxNode == aRMDSyntaxNode ifTrue: [ ^ self ].
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ 
			self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	super text: (aRMDSyntaxNode isString
			 ifTrue: [ aRMDSyntaxNode ]
			 ifFalse: [ self highlightedTextFrom: aRMDSyntaxNode ])
]

{ #category : #api }
RMDSourceTextPresenter >> text: aString [
	| aText |
	aText := aString asText.
	parser
		ifNil: [ syntaxNode := nil ]
		ifNotNil: [ | node |
			node := parser end parse: aText asString.
			node isPetit2Failure
				ifTrue: [ | node2 |
					node2 := parser parse: aString asString.
					node2 isPetit2Failure
						ifTrue: [ node := node2 ].
					aText
						makeColor: Color red
						from: (node position max: 1)
						to: aString size.
					self beError.
					syntaxNode := nil ]
				ifFalse: [ ^ self syntaxNode: node ] ].
	^ super text: aText
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
