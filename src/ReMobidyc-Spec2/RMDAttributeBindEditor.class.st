Class {
	#name : #RMDAttributeBindEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'exceptVariableNodes',
		'actionDefinitionNode',
		'replacementIcon',
		'expressionField',
		'placeholderList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'instance creation' }
RMDAttributeBindEditor class >> actionDefinition: aRMDActionDefinitionNode except: aCollectionOfRMDSyntaxNode [
	^ self new
		actionDefinitionNode: aRMDActionDefinitionNode;
		exceptVariableNodes: aCollectionOfRMDSyntaxNode;
		yourself
]

{ #category : #specs }
RMDAttributeBindEditor class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   vAlignCenter;
				   add: #placeholderList width: 200;
				   add: #replacementIcon width: 48;
				   add: #expressionField;
				   yourself)
		  height: self inputTextHeight;
		  yourself
]

{ #category : #accessing }
RMDAttributeBindEditor >> actionDefinitionNode [
	^ actionDefinitionNode
]

{ #category : #accessing }
RMDAttributeBindEditor >> actionDefinitionNode: aRMDActionDefinitionNode [
	actionDefinitionNode := aRMDActionDefinitionNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDAttributeBindEditor >> agentDirectiveMenu [

	| menu |
	menu := SpMenuPresenter new.
	actionDefinitionNode object.

	actionDefinitionNode object
		ifNotNil: [ :object | 
			menu
				addItem: [ :item | 
					| expr |
					expr := 'direction ' , object uncapitalized.
					item
						name: expr;
						action: [ self paste: expr ] ];
				addItem: [ :item | 
					| expr |
					expr := 'distance ' , object uncapitalized.
					item
						name: expr;
						action: [ self paste: expr ] ] ]
		ifNil: [ menu disable ].
	^ menu
]

{ #category : #accessing }
RMDAttributeBindEditor >> attributeBindNode [

	^ placeholderList selectedItem ifNotNil: [ :placeholder | 
		  expressionField syntaxNode ifNotNil: [ :replacement | 
			  RMDAttributeBindNode
				  placeholder: placeholder
				  replacement: replacement ] ]
]

{ #category : #accessing }
RMDAttributeBindEditor >> attributeBindNode: aRMDAttributeBindNode [

	aRMDAttributeBindNode
		ifNotNil: [ 
			placeholderList selectItem: aRMDAttributeBindNode placeholder.
			expressionField syntaxNode: aRMDAttributeBindNode replacement ]
		ifNil: [ 
			placeholderList selectItem: nil.
			expressionField text: '' ]
]

{ #category : #accessing }
RMDAttributeBindEditor >> exceptVariableNodes [
	^ exceptVariableNodes 
]

{ #category : #accessing }
RMDAttributeBindEditor >> exceptVariableNodes: aCollectionOfRMDSyntaxNode [
	exceptVariableNodes := aCollectionOfRMDSyntaxNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDAttributeBindEditor >> expressionFieldMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addItem: [ :item | 
		item
			name: 'directive';
			subMenu: self agentDirectiveMenu.
		item enabled: item subMenu isEnabled ].
	^ menu
]

{ #category : #initialization }
RMDAttributeBindEditor >> initializePresenters [

	super initializePresenters.
	placeholderList := self newDropList
		                   display: [ :item | item printString ];
		                   whenSelectionChangedDo:
			                   [ self updateExpressionFieldType ] yourself.
	replacementIcon := self newImage
		                   image: self replacementIcon;
		                   yourself.
	expressionField := self newSyntaxNodeTextInput
		                   beExpression;
		                   contextMenu: [ self expressionFieldMenu ];
		                   whenSyntaxNodeChangedDo: [ 
			                   self owner ifNotNil: [ :dialog | 
					                   dialog buttons first enabled:
							                   expressionField syntaxNode notNil ] ]
				                   yourself
]

{ #category : #initialization }
RMDAttributeBindEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Bindings for Adaptation'.
	aWindowPresenter
		initialExtent: 600 @ 150
]

{ #category : #menu }
RMDAttributeBindEditor >> paste: aString [

	Clipboard clipboardText: aString.
	expressionField withAdapterDo: [ :a | a widget textArea editor paste ]
]

{ #category : #updating }
RMDAttributeBindEditor >> updateExpressionFieldType [

	placeholderList selectedItem
		ifNotNil: [ :placeholder | 
			expressionField enable.
			placeholder isNewDirectiveNode
				ifTrue: [ expressionField beNewDirective ]
				ifFalse: [ expressionField beExpression ] ]
		ifNil: [ expressionField disable ]
]

{ #category : #accessing }
RMDAttributeBindEditor >> updatePlaceholderDropList [

	exceptVariableNodes ifNil: [ exceptVariableNodes := Array new ].
	placeholderList items: (Array streamContents: [ :stream | 
			 actionDefinitionNode placeholderNodesDo: [ :node | 
				 (exceptVariableNodes includes: node) ifFalse: [ 
					 stream nextPut: node ] ] ])
]
