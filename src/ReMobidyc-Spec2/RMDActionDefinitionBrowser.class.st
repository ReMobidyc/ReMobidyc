Class {
	#name : #RMDActionDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'repositoryList',
		'actionList',
		'sourceText',
		'addRepositoryButton',
		'removeRepositoryButton',
		'editRepositoryButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDActionDefinitionBrowser class >> defaultSpec [
	^ SpPanedLayout newVertical
		position: 0.4;
		add:
			(SpPanedLayout newHorizontal
				position: 0.5;
				add:
					(SpBoxLayout newVertical
						add: 'Repositories' expand: false;
						add: #repositoryList;
						add:
							(SpBoxLayout newHorizontal
								add: #addRepositoryButton width: self buttonHeight;
								add: #removeRepositoryButton width: self buttonHeight;
								add: #editRepositoryButton width: self buttonHeight;
								yourself)
							height: self buttonHeight;
						yourself);
				add:
					(SpBoxLayout newVertical
						add: 'Actions' expand: false;
						add: #actionList;
						yourself);
				yourself);
		add: #sourceText;
		yourself
]

{ #category : #'instance creation' }
RMDActionDefinitionBrowser class >> on: aRMDSimulationModel [
	^ self new
		simulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #'instance creation' }
RMDActionDefinitionBrowser class >> withoutInterpreter [
	^ self new
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> actionIdentifier [ 
	^ actionList selection selectedItem
]

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializePresenters [
	super initializePresenters.
	repositoryList := self newList
		beSingleSelection;
		whenModelChangedDo: [ repositoryList selectItem: nil ];
		whenSelectionChangedDo: [ self updateActionList ];
		display: [ :item | item repositoryName ];
		yourself.
	addRepositoryButton := self newButton
		icon: self addIcon;
		action: [ self addRepository ];
		yourself.
	removeRepositoryButton := self newButton
		icon: self removeIcon;
		action: [ self removeRepository ];
		disable;
		yourself.
	editRepositoryButton := self newButton
		icon: self editIcon;
		action: [ self editRepository ];
		disable;
		yourself.
	actionList := self newTable
		beSingleSelection;
		beResizable;
		showColumnHeaders;
		addColumn:
			(SpStringTableColumn
				title: 'verb'
				evaluated: [ :item | (item resolveWith: simulationModel) identifier ]);
		addColumn:
			(SpStringTableColumn
				title: 'object'
				evaluated: [ :item | (item resolveWith: simulationModel) object ifNil: [ '' ] ]);
		whenModelChangedDo: [ actionList selectItem: nil ];
		whenSelectionChangedDo: [ self updateSourceText ];
		yourself.
	sourceText := (self newSourceWith: RMDGrammar new actionDefinition)
		enabled: false;
		whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		yourself.
	self updateRepositoryList
]

{ #category : #initialization }
RMDActionDefinitionBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Actions'.
	aWindowPresenter initialExtent: 800 @ 600
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> repositories [
	^ Array
		streamContents: [ :stream | 
			stream nextPut: RMDBuiltinRepository current.
			simulationModel ifNotNil: [ stream nextPut: simulationModel ] ]
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> repository [
	^ repositoryList selection selectedItem
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> simulationModel [
	^ simulationModel
]

{ #category : #accessing }
RMDActionDefinitionBrowser >> simulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateActionList [
	actionList
		items:
			(self repository
				ifNotNil: [ :repository | repository actionIdentifiers ]
				ifNil: [ #() ])
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateRepositoryList [
	repositoryList items: self repositories
]

{ #category : #updating }
RMDActionDefinitionBrowser >> updateSourceText [
	self actionIdentifier
		ifNotNil: [ :actionIdentifier | 
			sourceText
				syntaxNode: (actionIdentifier resolveWith: simulationModel);
				enabled: actionIdentifier isReadOnly not ]
		ifNil: [ sourceText
				text: '';
				enabled: false ]
]
