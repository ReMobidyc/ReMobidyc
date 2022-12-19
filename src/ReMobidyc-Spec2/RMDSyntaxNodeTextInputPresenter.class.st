Class {
	#name : #RMDSyntaxNodeTextInputPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TRMDPresenter + TRMDTemplateMenu',
	#classTraits : 'TRMDPresenter classTrait + TRMDTemplateMenu classTrait',
	#instVars : [
		'#syntaxNode => ObservableSlot',
		'#lastValidSyntaxNode => ObservableSlot',
		'#parser',
		'#submitActions'
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
RMDSyntaxNodeTextInputPresenter >> allowEmpty [
	parser := parser optional end
]

{ #category : #private }
RMDSyntaxNodeTextInputPresenter >> basicSyntaxNode: aRMDSyntaxNode [

	syntaxNode := aRMDSyntaxNode.
	syntaxNode
		ifNil: [ 
			self beOk.
			lastValidSyntaxNode := aRMDSyntaxNode ]
		ifNotNil: [ 
			syntaxNode isString
				ifTrue: [ 
					self beOk.
					lastValidSyntaxNode := aRMDSyntaxNode ]
				ifFalse: [ 
					(aRMDSyntaxNode isKindOf: RMDSyntaxNode)
						ifTrue: [ 
							self beOk.
							lastValidSyntaxNode := aRMDSyntaxNode ]
						ifFalse: [ self beError ] ] ]
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
RMDSyntaxNodeTextInputPresenter >> beCondition [
	self parser: RMDGrammar new condition end
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
RMDSyntaxNodeTextInputPresenter >> beNewDirective [

	self parser: RMDGrammar new newDirective end
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> beStageDirective [

	self parser: RMDGrammar new stageDirective end
]

{ #category : #accessing }
RMDSyntaxNodeTextInputPresenter >> color: aColor [

	super color: aColor.
	self withWidgetDo: [ :w | w notNil ifTrue: [ w color: aColor ] ]
]

{ #category : #private }
RMDSyntaxNodeTextInputPresenter >> doTextPaste [

	self adapter pasteText
]

{ #category : #initialization }
RMDSyntaxNodeTextInputPresenter >> initialize [

	super initialize.
	submitActions := OrderedCollection with: [ :t | self prettyPrint ].
	self
		bindKeyCombination: SpAcceptChangesCommand defaultShortcutKey
			| Character cr asKeyCombination
		toAction: [ 
			submitActions do: [ :submitAction | 
				submitAction cull: self syntaxNode cull: self text ] ]
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
RMDSyntaxNodeTextInputPresenter >> prettyPrint [
	self syntaxNode: self lastValidSyntaxNode
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> syntaxNode [
	^ syntaxNode
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> syntaxNode: aRMDSyntaxNode [

	self basicSyntaxNode: aRMDSyntaxNode.
	text := aRMDSyntaxNode ifNil: [ '' ] ifNotNil: #asString
]

{ #category : #api }
RMDSyntaxNodeTextInputPresenter >> text: aString [

	| newText node |
	newText := aString asText.
	node := parser end parse: aString asString.
	^ node isPetit2Failure
		  ifTrue: [ 
			  | node2 |
			  node2 := parser parse: aString asString.
			  node2 isPetit2Failure ifTrue: [ node := node2 ].
			  newText
				  makeColor: Color red
				  from: (node position + 1 min: aString size max: 1)
				  to: aString size.
			  self beError.
			  syntaxNode := nil.
			  text := newText ]
		  ifFalse: [ 
			  self basicSyntaxNode: node.
			  text := aString ]
]

{ #category : #'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenLastValidSyntaxNodeChangedDo: aBlock [
	self property: #lastValidSyntaxNode whenChangedDo: aBlock
]

{ #category : #'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenSubmitDo: aBlock [

	submitActions add: aBlock
]

{ #category : #'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenSyntaxNodeChangedDo: aBlock [
	self property: #syntaxNode whenChangedDo: aBlock
]
