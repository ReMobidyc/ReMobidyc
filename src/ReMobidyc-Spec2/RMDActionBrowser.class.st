Class {
	#name : #RMDActionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'list',
		'source'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDActionBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.3;
		add: #list;
		add: #source;
		yourself
]

{ #category : #examples }
RMDActionBrowser class >> example1 [
	RMDActionBrowser new
		interpreter: RMDInterpreter sugarScape;
		openWithSpec
]

{ #category : #'instance creation' }
RMDActionBrowser class >> on: aRMDInterpreter [
	^ self new
		interpreter: aRMDInterpreter;
		yourself
]

{ #category : #initialization }
RMDActionBrowser >> initializePresenters [
	super initializePresenters.
	list := self newList
		whenSelectionChangedDo: [ :selection | [ self updateSource ] cull: selection selectedItem ];
		yourself.
	source := (self newSourceWith: RMDGrammar new actionDefinition end)
		whenLastValidSyntaxNodeChangedDo: [ :actionNode | 
			interpreter
				ifNotNil: [ interpreter load: actionNode.
					self
						updateList;
						updateSource ] ];
		yourself
]

{ #category : #accessing }
RMDActionBrowser >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDActionBrowser >> interpreter: aRMDSimulationModel [
	interpreter := aRMDSimulationModel.
	self interpreterChanged
]

{ #category : #accessing }
RMDActionBrowser >> interpreterChanged [
	self
		updateList;
		updateSource
]

{ #category : #accessing }
RMDActionBrowser >> updateList [
	| item |
	item := list selection selectedItem.
	list items: (interpreter ifNil: [ Array new ] ifNotNil: #actionNames).
	list selectItem: item
]

{ #category : #accessing }
RMDActionBrowser >> updateSource [
	interpreter
		ifNil: [ source text: String new.
			^ self ].
	list selection selectedItem
		ifNotNil: [ :name | 
			source
				syntaxNode: (interpreter actionDefinitionAt: name ifAbsent: [ ^ self ]) ]
]
