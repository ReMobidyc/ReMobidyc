Class {
	#name : #RMDBehaviorBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'interpreter',
		'list',
		'source',
		'action'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDBehaviorBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.3;
		add: #list;
		add:
			(SpPanedLayout newHorizontal
				position: 0.4;
				add: #source;
				add: #action;
				yourself);
		yourself
]

{ #category : #examples }
RMDBehaviorBrowser class >> example1 [
	RMDBehaviorBrowser new
		interpreter: RMDInterpreter sugarScape;
		openWithSpec
]

{ #category : #'instance creation' }
RMDBehaviorBrowser class >> on: aRMDInterpreter [
	^ self new
		interpreter: aRMDInterpreter;
		yourself
]

{ #category : #initialization }
RMDBehaviorBrowser >> initializePresenters [
	super initializePresenters.
	list := self newList
		display: [ :item | item name ];
		whenSelectionChangedDo: [ self updateSource ];
		yourself.
	source := (self newSourceWith: RMDGrammar new behaviorDefinition end)
		whenLastValidSyntaxNodeChangedDo: [ :behaviorNode | 
			list selection selectedItem == behaviorNode
				ifFalse: [ interpreter
						ifNotNil: [ interpreter
								replaceBehavior: list selection selectedItem
								with: behaviorNode.
							self updateList.
							list selectItem: behaviorNode ] ].
			self updateAction ];
		yourself.
	action := self newText
		enabled: false;
		whenBuiltDo: [ action color: (Color gray: 0.9) ];
		yourself
]

{ #category : #accessing }
RMDBehaviorBrowser >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDBehaviorBrowser >> interpreter: aRMDSimulationModel [
	interpreter := aRMDSimulationModel.
	self interpreterChanged
]

{ #category : #accessing }
RMDBehaviorBrowser >> interpreterChanged [
	self
		updateList;
		updateSource;
		updateAction
]

{ #category : #accessing }
RMDBehaviorBrowser >> updateAction [
	interpreter
		ifNil: [ action text: String new.
			^ self ].
	source syntaxNode
		ifNotNil:
			[ :behavior | action text: (behavior actionWith: interpreter) printString ]
]

{ #category : #accessing }
RMDBehaviorBrowser >> updateList [
	| item |
	item := list selection selectedItem.
	list
		items: (interpreter ifNil: [ Array new ] ifNotNil: #behaviorDefinitions)
]

{ #category : #accessing }
RMDBehaviorBrowser >> updateSource [
	interpreter
		ifNil: [ source text: String new.
			^ self ].
	list selection selectedItem
		ifNotNil: [ :behavior | source syntaxNode: behavior ]
]
