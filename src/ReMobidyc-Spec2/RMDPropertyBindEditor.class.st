Class {
	#name : #RMDPropertyBindEditor,
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
RMDPropertyBindEditor class >> actionDefinition: aRMDActionDefinitionNode except: aCollectionOfRMDSyntaxNode [
	^ self new
		actionDefinitionNode: aRMDActionDefinitionNode;
		exceptVariableNodes: aCollectionOfRMDSyntaxNode;
		yourself
]

{ #category : #specs }
RMDPropertyBindEditor class >> defaultSpec [

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
RMDPropertyBindEditor >> actionDefinitionNode [
	^ actionDefinitionNode
]

{ #category : #accessing }
RMDPropertyBindEditor >> actionDefinitionNode: aRMDActionDefinitionNode [
	actionDefinitionNode := aRMDActionDefinitionNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDPropertyBindEditor >> agentDirectiveMenu [

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
RMDPropertyBindEditor >> exceptVariableNodes [
	^ exceptVariableNodes 
]

{ #category : #accessing }
RMDPropertyBindEditor >> exceptVariableNodes: aCollectionOfRMDSyntaxNode [
	exceptVariableNodes := aCollectionOfRMDSyntaxNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDPropertyBindEditor >> expressionFieldMenu [

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
RMDPropertyBindEditor >> initializePresenters [

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
RMDPropertyBindEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Bindings for Adaptation'.
	aWindowPresenter
		initialExtent: 600 @ 150
]

{ #category : #menu }
RMDPropertyBindEditor >> paste: aString [

	Clipboard clipboardText: aString.
	expressionField withAdapterDo: [ :a | a widget textArea editor paste ]
]

{ #category : #accessing }
RMDPropertyBindEditor >> propertyBindNode [

	^ placeholderList selectedItem ifNotNil: [ :placeholder | 
		  expressionField syntaxNode ifNotNil: [ :replacement | 
			  RMDPropertyBindNode
				  placeholder: placeholder
				  replacement: replacement ] ]
]

{ #category : #accessing }
RMDPropertyBindEditor >> propertyBindNode: aRMDPropertyBindNode [

	aRMDPropertyBindNode
		ifNotNil: [ 
			placeholderList selectItem: aRMDPropertyBindNode placeholder.
			expressionField syntaxNode: aRMDPropertyBindNode replacement ]
		ifNil: [ 
			placeholderList selectItem: nil.
			expressionField text: '' ]
]

{ #category : #updating }
RMDPropertyBindEditor >> updateExpressionFieldType [

	placeholderList selectedItem
		ifNotNil: [ :placeholder | 
			expressionField enable.
			placeholder isNewDirectiveNode
				ifTrue: [ expressionField beNewDirective ]
				ifFalse: [ expressionField beExpression ] ]
		ifNil: [ expressionField disable ]
]

{ #category : #accessing }
RMDPropertyBindEditor >> updatePlaceholderDropList [

	exceptVariableNodes ifNil: [ exceptVariableNodes := Array new ].
	placeholderList items: (Array streamContents: [ :stream | 
			 actionDefinitionNode placeholderNodesDo: [ :node | 
				 (exceptVariableNodes includes: node) ifFalse: [ 
					 stream nextPut: node ] ] ])
]
