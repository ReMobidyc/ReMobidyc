Class {
	#name : #RMDActionSpecializer,
	#superclass : #RMDPresenter,
	#instVars : [
		'baseAction',
		'parser',
		'baseSourceText',
		'nameField',
		'replacementList',
		'addReplacementButton',
		'removeReplacementButton',
		'editReplacementButton',
		'actionSourceText'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDActionSpecializer class >> defaultSpec [
	<spec>
	^ SpPanedLayout newVertical
		position: 0.3;
		add:
			(SpBoxLayout newVertical
				add: 'Original source' expand: false;
				add: #baseSourceText;
				yourself);
		add:
			(SpPanedLayout newVertical
				position: 4.0 / 7.0;
				add:
					(SpBoxLayout newVertical
						add:
							(SpBoxLayout newVertical
								add: 'Name' expand: false;
								add: #nameField width: 400;
								yourself)
							height: self inputTextHeight * 2;
						add:
							(SpBoxLayout newVertical
								add: 'Replacements' expand: false;
								add: #replacementList;
								add:
									(SpBoxLayout newHorizontal
										add: #addReplacementButton width: self buttonHeight;
										add: #removeReplacementButton width: self buttonHeight;
										add: #editReplacementButton width: self buttonHeight;
										yourself)
									height: self buttonHeight;
								yourself);
						yourself);
				add:
					(SpBoxLayout newVertical
						add: 'Source' expand: false;
						add: #actionSourceText;
						yourself);
				yourself);
		yourself
]

{ #category : #accessing }
RMDActionSpecializer >> action [
	^ baseAction
		ifNotNil: [ (baseAction
				copyReplace: (replacementList items collect: [ :pair | pair first -> pair second ]))
				identifier:
					(nameField lastValidText asString trim
						ifNil: [ baseAction identifier ]) ]
]

{ #category : #accessing }
RMDActionSpecializer >> actionSource [
	^ self action
		ifNotNil: [ :actionDefinition | actionDefinition printString ]
		ifNil: [ '' ]
]

{ #category : #operations }
RMDActionSpecializer >> addReplacement [
	^ self notYetImplemented
]

{ #category : #accessing }
RMDActionSpecializer >> baseAction [
	^ baseAction
]

{ #category : #accessing }
RMDActionSpecializer >> baseAction: aRMDActionDefinitionNode [
	baseAction := aRMDActionDefinitionNode
]

{ #category : #operations }
RMDActionSpecializer >> editReplacement [
	^ self notYetImplemented
]

{ #category : #initialization }
RMDActionSpecializer >> initializePresenters [
	super initializePresenters.
	baseSourceText := self newText
		enabled: false;
		yourself.
	nameField := self newValidatedTextInput
		validation:
				[ :name | (self parser identifier end parse: name) isPetit2Failure not ];
		whenLastValidTextChangedDo: [ self updateActionSourceText ];
		yourself.
	replacementList := self newTable
		beSingleSelection;
		beResizable;
		addColumn:
			(SpStringTableColumn
				evaluated:
					[ :item | item actionAgent ifNil: [ 'my' ] ifNotNil: [ :agent | agent , '''s' ] ])
				beNotExpandable;
		addColumn:
			(SpStringTableColumn evaluated: [ :item | item actionProperty ])
				beNotExpandable;
		addColumn:
			((SpImageTableColumn evaluated: [ :item | self replacementIcon ])
				width: 20);
		addColumn:
			((SpStringTableColumn
				evaluated: [ :item | item expression printString ]) width: 200)
				beExpandable;
		whenModelChangedDo: [ replacementList selectItem: nil ];
		whenSelectionChangedDo: [ | selected |
			selected := replacementList selection selectedItem notNil.
			removeReplacementButton enabled: selected.
			editReplacementButton enabled: selected ];
		yourself.
	addReplacementButton := self newButton
		icon: self addIcon;
		action: [ self addReplacement ];
		yourself.
	removeReplacementButton := self newButton
		icon: self removeIcon;
		action: [ self removeReplacement ];
		disable;
		yourself.
	editReplacementButton := self newButton
		icon: self editIcon;
		action: [ self editReplacement ];
		disable;
		yourself.
	actionSourceText := self newText enabled: false
]

{ #category : #accessing }
RMDActionSpecializer >> parser [
	^ parser ifNil: [ parser := RMDGrammar new ]
]

{ #category : #operations }
RMDActionSpecializer >> removeReplacement [
	^ self notYetImplemented
]

{ #category : #updating }
RMDActionSpecializer >> updateActionSourceText [
	actionSourceText text: self actionSource
]
