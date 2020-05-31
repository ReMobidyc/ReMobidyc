Class {
	#name : #RMDBehaviorBrowser,
	#superclass : #RMDAbstractDefinitionBrowser,
	#instVars : [
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

{ #category : #accessing }
RMDBehaviorBrowser >> getListSelector [
	^ #behaviorDefinitions
]

{ #category : #accessing }
RMDBehaviorBrowser >> getSource: aRMDBehaviorDefinitionNode ifAbsent: aBlock [
	^ aRMDBehaviorDefinitionNode ifNil: aBlock
]

{ #category : #initialization }
RMDBehaviorBrowser >> initializePresenters [
	super initializePresenters.
	list display: [ :item | item name ].
	action := self newText
		enabled: false;
		whenBuiltDo: [ action color: (Color gray: 0.9) ];
		yourself
]

{ #category : #accessing }
RMDBehaviorBrowser >> interpreterChanged [
	super interpreterChanged.
	self updateAction
]

{ #category : #accessing }
RMDBehaviorBrowser >> parser [
	^ RMDGrammar new behaviorDefinition end
]

{ #category : #accessing }
RMDBehaviorBrowser >> sourceAccepted: aRMDBehaviorDefinitionNode [
	list selection selectedItem == aRMDBehaviorDefinitionNode
		ifFalse: [ interpreter
				ifNotNil: [ interpreter
						replaceBehavior: list selection selectedItem
						with: aRMDBehaviorDefinitionNode.
					self updateList.
					list selectItem: aRMDBehaviorDefinitionNode ] ].
	self updateAction
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
RMDBehaviorBrowser >> updateSource [
	interpreter
		ifNil: [ source text: String new.
			^ self ].
	list selection selectedItem
		ifNotNil: [ :behavior | source syntaxNode: behavior ]
]
