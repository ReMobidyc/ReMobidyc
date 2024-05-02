Class {
	#name : 'RMDSyntaxNodeTextInputPresenter',
	#superclass : 'SpTextInputFieldPresenter',
	#traits : 'TRMDPresenter + TRMDTemplateMenu',
	#classTraits : 'TRMDPresenter classTrait + TRMDTemplateMenu classTrait',
	#instVars : [
		'#syntaxNode => ObservableSlot',
		'#lastValidSyntaxNode => ObservableSlot',
		'#parser',
		'#display',
		'#submitActions'
	],
	#category : 'ReMobidyc-Spec2-Widgets',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forAgentIdentifier [
	^ self on: RMDGrammar current agentIdentifier end
]

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forAgentReference [
	^ self on: RMDGrammar current agentReference end
]

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forExpression [
	^ self on: RMDGrammar current expression end
]

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forIdentifier [
	^ self on: RMDGrammar current identifier end
]

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> forLiteral [
	^ self on: RMDGrammar current literal end
]

{ #category : 'instance creation' }
RMDSyntaxNodeTextInputPresenter class >> on: aParser [
	^ self new
		parser: aParser;
		yourself
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> allowEmpty [
	parser := parser ifNotNil: [parser optional end]
]

{ #category : 'private' }
RMDSyntaxNodeTextInputPresenter >> basicSyntaxNode: aRMDSyntaxNode [

	self beOk.
	syntaxNode := aRMDSyntaxNode.
	lastValidSyntaxNode := aRMDSyntaxNode
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beAgentIdentifier [
	self parser: RMDGrammar current agentIdentifier end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beAgentReference [
	self parser: RMDGrammar current agentReference end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beCondition [
	self parser: RMDGrammar current condition end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beExpression [

	self parser: RMDGrammar current expression end.
	self text: self text asString
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beFreeText [

	self parser: nil.
	self text: self text asString
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beIdentifier [
	self parser: RMDGrammar current identifier end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beLiteral [
	self parser: RMDGrammar current literal end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beNewDirective [

	self parser: RMDGrammar current newDirective end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> beStageDirective [

	self parser: RMDGrammar current stageDirective end
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> display [

	^ display
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> display: aBlock [

	display := aBlock
]

{ #category : 'private' }
RMDSyntaxNodeTextInputPresenter >> doTextPaste [

	self adapter pasteText
]

{ #category : 'initialization' }
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

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> lastValidSyntaxNode [
	^ lastValidSyntaxNode
]

{ #category : 'accessing' }
RMDSyntaxNodeTextInputPresenter >> parser [
	^ parser
]

{ #category : 'accessing' }
RMDSyntaxNodeTextInputPresenter >> parser: aParser [
	parser := aParser
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> prettyPrint [
	self syntaxNode: self lastValidSyntaxNode
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> syntaxNode [
	^ syntaxNode
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> syntaxNode: aRMDSyntaxNode [

	self basicSyntaxNode: aRMDSyntaxNode.
	text := aRMDSyntaxNode ifNil: [ '' ] ifNotNil: [ 
		        display
			        ifNil: [ aRMDSyntaxNode asString ]
			        ifNotNil: [ display value: aRMDSyntaxNode ] ]
]

{ #category : 'api' }
RMDSyntaxNodeTextInputPresenter >> text: aString [

	| newText node |
	newText := aString asText.
	node := parser ifNotNil: [ parser end parse: aString asString ].
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

{ #category : 'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenLastValidSyntaxNodeChangedDo: aBlock [
	self property: #lastValidSyntaxNode whenChangedDo: aBlock
]

{ #category : 'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenSubmitDo: aBlock [

	submitActions add: aBlock
]

{ #category : 'api-events' }
RMDSyntaxNodeTextInputPresenter >> whenSyntaxNodeChangedDo: aBlock [
	self property: #syntaxNode whenChangedDo: aBlock
]
