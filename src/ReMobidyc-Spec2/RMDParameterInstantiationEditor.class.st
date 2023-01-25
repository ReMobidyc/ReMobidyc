Class {
	#name : #RMDParameterInstantiationEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'exceptVariableNodes',
		'actionDefinitionNode',
		'replacementIcon',
		'expressionField',
		'placeholderList',
		'hasObject'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #'instance creation' }
RMDParameterInstantiationEditor class >> actionDefinition: aRMDActionDefinitionNode except: aCollectionOfRMDSyntaxNode [
	^ self new
		actionDefinitionNode: aRMDActionDefinitionNode;
		exceptVariableNodes: aCollectionOfRMDSyntaxNode;
		yourself
]

{ #category : #layout }
RMDParameterInstantiationEditor class >> defaultLayout [

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
RMDParameterInstantiationEditor >> actionDefinitionNode [
	^ actionDefinitionNode
]

{ #category : #accessing }
RMDParameterInstantiationEditor >> actionDefinitionNode: aRMDActionDefinitionNode [
	actionDefinitionNode := aRMDActionDefinitionNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDParameterInstantiationEditor >> agentDirectiveMenu [

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
RMDParameterInstantiationEditor >> exceptVariableNodes [
	^ exceptVariableNodes 
]

{ #category : #accessing }
RMDParameterInstantiationEditor >> exceptVariableNodes: aCollectionOfRMDSyntaxNode [
	exceptVariableNodes := aCollectionOfRMDSyntaxNode.
	self updatePlaceholderDropList
]

{ #category : #menu }
RMDParameterInstantiationEditor >> expressionFieldMenu [

	| menu |
	menu := SpMenuPresenter new.
	menu addItem: [ :item | 
		item
			name: 'templates...';
			subMenu: expressionField templateMenu ].
	^ menu
]

{ #category : #initialization }
RMDParameterInstantiationEditor >> initializePresenters [

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
RMDParameterInstantiationEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Bindings for Adaptation'.
	aWindowPresenter
		initialExtent: 600 @ 150
]

{ #category : #accessing }
RMDParameterInstantiationEditor >> parameterInstantiationNode [

	^ placeholderList selectedItem ifNotNil: [ :placeholder | 
		  expressionField syntaxNode ifNotNil: [ :replacement | 
			  RMDParameterInstantiationNode
				  placeholder: placeholder
				  replacement: replacement ] ]
]

{ #category : #accessing }
RMDParameterInstantiationEditor >> parameterInstantiationNode: aRMDParameterInstantiationNode [

	aRMDParameterInstantiationNode
		ifNotNil: [ 
			placeholderList selectItem: aRMDParameterInstantiationNode placeholder.
			expressionField syntaxNode: aRMDParameterInstantiationNode replacement ]
		ifNil: [ 
			placeholderList selectItem: nil.
			expressionField text: '' ]
]

{ #category : #menu }
RMDParameterInstantiationEditor >> paste: aString [

	Clipboard clipboardText: aString.
	expressionField withAdapterDo: [ :a | a widget textArea editor paste ]
]

{ #category : #updating }
RMDParameterInstantiationEditor >> updateExpressionFieldType [

	placeholderList selectedItem
		ifNotNil: [ :placeholder | 
			expressionField enable.
			placeholder isNewDirectiveNode
				ifTrue: [ expressionField beNewDirective ]
				ifFalse: [ 
					placeholder isStageDirectiveNode
						ifTrue: [ expressionField beStageDirective ]
						ifFalse: [ 
							(placeholder isConditionPlaceholderIn: actionDefinitionNode)
								ifTrue: [ expressionField beCondition ]
								ifFalse: [ expressionField beExpression ] ] ] ]
		ifNil: [ expressionField disable ]
]

{ #category : #accessing }
RMDParameterInstantiationEditor >> updatePlaceholderDropList [

	| done |
	exceptVariableNodes ifNil: [ exceptVariableNodes := Array new ].
	done := Set new: 256.
	placeholderList items: (Array streamContents: [ :stream | 
			 actionDefinitionNode placeholderNodesDo: [ :node | 
				 ((exceptVariableNodes includes: node) or: [ done includes: node ]) 
					 ifFalse: [ 
						 stream nextPut: node.
						 done add: node ] ] ])
]
