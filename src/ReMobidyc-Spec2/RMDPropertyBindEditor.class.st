Class {
	#name : #RMDPropertyBindEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'exceptVariableNodes',
		'actionDefinitionNode',
		'propertyVariableList',
		'replacementIcon',
		'expressionField'
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
		add:
			(SpPanedLayout newHorizontal
				position: 0.4;
				add:
					(SpBoxLayout newHorizontal
						add: #propertyVariableList;
						add: #replacementIcon width: 48;
						yourself);
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
	self updatePropertyVariableDropList
]

{ #category : #accessing }
RMDPropertyBindEditor >> exceptVariableNodes [
	^ exceptVariableNodes 
]

{ #category : #accessing }
RMDPropertyBindEditor >> exceptVariableNodes: aCollectionOfRMDSyntaxNode [
	exceptVariableNodes := aCollectionOfRMDSyntaxNode.
	self updatePropertyVariableDropList
]

{ #category : #initialization }
RMDPropertyBindEditor >> initializePresenters [
	super initializePresenters.
	propertyVariableList := self newDropList
		display: [ :item | item printString ];
		yourself.
	replacementIcon := self newImage
		image: self replacementIcon;
		yourself.
	expressionField := self newSyntaxNodeTextInput
		beExpression;
		autoAccept: true;
		whenSyntaxNodeChangedDo:
			[ self owner
				ifNotNil:
					[ :dialog | dialog buttons first enabled: expressionField syntaxNode notNil ] ]
				yourself
]

{ #category : #initialization }
RMDPropertyBindEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Bindings for Adaptation'.
	aWindowPresenter
		initialExtent: 600 @ 150
]

{ #category : #accessing }
RMDPropertyBindEditor >> propertyBindNode [
	^ propertyVariableList selectedItem
		ifNotNil: [ :propertyVariable | 
			expressionField syntaxNode
				ifNotNil: [ :expression | 
					RMDPropertyBindNode
						actionAgent: propertyVariable agent
						property: propertyVariable identifier
						expression: expression ] ]
]

{ #category : #accessing }
RMDPropertyBindEditor >> propertyBindNode: aRMDPropertyBindNode [
	aRMDPropertyBindNode
		ifNotNil: [ propertyVariableList
				selectItem:
					(RMDPropertyVariableNode
						identifier: aRMDPropertyBindNode actionProperty
						agent: aRMDPropertyBindNode actionAgent).
			expressionField syntaxNode: aRMDPropertyBindNode expression ]
		ifNil: [ propertyVariableList selectItem: nil.
			expressionField text: '' ]
]

{ #category : #accessing }
RMDPropertyBindEditor >> updatePropertyVariableDropList [
	exceptVariableNodes ifNil: [ exceptVariableNodes := Array new ].
	propertyVariableList
		items:
			(Array
				streamContents: [ :stream | 
					actionDefinitionNode
						propertyVariableNodesDo: [ :node | 
							(exceptVariableNodes includes: node)
								ifFalse: [ stream nextPut: node ] ] ])
]
