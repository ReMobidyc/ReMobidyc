Class {
	#name : #RMDSourceTextPresenter,
	#superclass : #SpTextPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#syntaxNode => SpObservableSlot',
		'#lastValidSyntaxNode => SpObservableSlot',
		'#parser'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #api }
RMDSourceTextPresenter >> acceptSyntaxNode: aRMDSyntaxNode [
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	self acceptText: aRMDSyntaxNode printString
]

{ #category : #initialization }
RMDSourceTextPresenter >> initialize [
	super initialize.
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
	syntaxNode == aRMDSyntaxNode ifTrue: [ ^self ].
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	super text: aRMDSyntaxNode printString
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
				ifFalse: [ self beOk.
					syntaxNode := node.
					lastValidSyntaxNode := node.
					aText := node printString ] ].
	super text: aText
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
