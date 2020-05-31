Class {
	#name : #RMDAbstractDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'source',
		'interpreter',
		'list'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDAbstractDefinitionBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.3;
		add: #list;
		add: #source;
		yourself
]

{ #category : #'instance creation' }
RMDAbstractDefinitionBrowser class >> on: aRMDInterpreter [
	^ self new
		interpreter: aRMDInterpreter;
		yourself
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> getListSelector [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> getSource: aString ifAbsent: aBlock [
	^ self subclassResponsibility
]

{ #category : #initialization }
RMDAbstractDefinitionBrowser >> initializePresenters [
	super initializePresenters.
	list := self newList
		whenSelectionChangedDo: [ :selection | [ self updateSource ] cull: selection selectedItem ];
		yourself.
	source := (self newSourceWith: self parser)
		whenLastValidSyntaxNodeChangedDo: [ :syntaxNode | self sourceAccepted: syntaxNode ];
		yourself
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> interpreter: aRMDSimulationModel [
	interpreter := aRMDSimulationModel.
	self interpreterChanged
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> interpreterChanged [
	self
		updateList;
		updateSource
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> parser [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> sourceAccepted: aRMDSyntaxNode [
	interpreter
		ifNotNil: [ interpreter load: aRMDSyntaxNode.
			self
				updateList;
				updateSource ]
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> updateList [
	| item |
	item := list selection selectedItem.
	list
		items: (interpreter ifNil: [ Array new ] ifNotNil: self getListSelector).
	list selectItem: item
]

{ #category : #accessing }
RMDAbstractDefinitionBrowser >> updateSource [
	interpreter
		ifNil: [ source text: String new.
			^ self ].
	list selection selectedItem
		ifNotNil:
			[ :name | source syntaxNode: (self getSource: name ifAbsent: [ ^ self ]) ]
]
