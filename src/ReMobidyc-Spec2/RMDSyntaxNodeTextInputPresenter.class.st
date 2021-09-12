Class {
	#name : #RMDSyntaxNodeTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TRMDPresenter',
	#classTraits : 'TRMDPresenter classTrait',
	#instVars : [
		'#syntaxNode => ObservableSlot',
		'#lastValidSyntaxNode => ObservableSlot',
		'#parser'
	],
	#category : #'ReMobidyc-Spec2-Widgets'
}

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forAgentIdentifier [
	^ self on: RMDGrammar new agentIdentifier end
]

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forAgentReference [
	^ self on: RMDGrammar new agentReference end
]

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forExpression [
	^ self on: RMDGrammar new expression end
]

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forIdentifier [
	^ self on: RMDGrammar new identifier end
]

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forLiteral [
	^ self on: RMDGrammar new literal end
]

{ #category : #'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> on: aParser [
	^ self new
		parser: aParser;
		yourself
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> acceptSyntaxNode: aRMDSyntaxNode [
	syntaxNode := aRMDSyntaxNode.
	(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
		ifTrue: [ self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifFalse: [ self beError ].
	self accept: aRMDSyntaxNode printString
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> allowEmpty [
	parser := parser / '' asPParser end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beAgentIdentifier [
	self parser: RMDGrammar new agentIdentifier end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beAgentReference [
	self parser: RMDGrammar new agentReference end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beExpression [
	self parser: RMDGrammar new expression end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beIdentifier [
	self parser: RMDGrammar new identifier end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beLiteral [
	self parser: RMDGrammar new literal end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> lastValidSyntaxNode [
	^ lastValidSyntaxNode
]

{ #category : #accessing }
RMDSyntaxNodeTextInputPresenter >> parser [
	^ parser
]

{ #category : #accessing }
RMDSyntaxNodeTextInputPresenter >> parser: aParser [
	parser := aParser
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> syntaxNode [
	^ syntaxNode
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> syntaxNode: aRMDSyntaxNode [
	syntaxNode := aRMDSyntaxNode.
	syntaxNode isString
		ifTrue: [ self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode.
			text := aRMDSyntaxNode ]
		ifFalse: [ (aRMDSyntaxNode isKindOf: RMDSyntaxNode)
				ifTrue: [ self beOk.
					lastValidSyntaxNode := aRMDSyntaxNode ]
				ifFalse: [ self beError ].
			text := aRMDSyntaxNode printString ]
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> text: aString [
	| newText node |
	newText := aString asText.
	node := parser end parse: aString asString.
	^ node isPetit2Failure
		ifTrue: [ | node2 |
			node2 := parser parse: aString asString.
			node2 isPetit2Failure
				ifTrue: [ node := node2 ].
			newText
				makeColor: Color red
				from: (node position + 1 min: aString size max: 1)
				to: aString size.
			self beError.
			syntaxNode := nil.
			super text: newText ]
		ifFalse: [ self syntaxNode: node ]
]

{ #category : #'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenLastValidSyntaxNodeChangedDo: aBlock [
	self property: #lastValidSyntaxNode whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenSyntaxNodeChangedDo: aBlock [
	self property: #syntaxNode whenChangedDo: aBlock
]
