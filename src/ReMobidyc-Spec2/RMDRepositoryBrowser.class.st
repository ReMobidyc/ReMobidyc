Class {
	#name : #RMDRepositoryBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'repositoryList',
		'actionList',
		'addRepositoryButton',
		'removeRepositoryButton',
		'editRepositoryButton',
		'sourceText'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDRepositoryBrowser class >> defaultSpec [

	^ SpPanedLayout newVertical
		  add: (SpPanedLayout newHorizontal
				   add: #repositoryList;
				   add: #actionList;
				   yourself);
		  add: #sourceText;
		  positionOfSlider: 0.4;
		  yourself
]

{ #category : #accessing }
RMDRepositoryBrowser >> action [

	^ actionList selection selectedItem
]

{ #category : #operations }
RMDRepositoryBrowser >> addRepository [
	^ self notYetImplemented
]

{ #category : #operations }
RMDRepositoryBrowser >> editRepository [
	^ self notYetImplemented
]

{ #category : #initialization }
RMDRepositoryBrowser >> initializePresenters [

	super initializePresenters.
	repositoryList := self newList
		                  beSingleSelection;
		                  whenModelChangedDo: [ 
			                  repositoryList selectItem: nil ];
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
		              addColumn: (SpStringTableColumn
				               title: 'verb'
				               evaluated: [ :item | item identifier ]);
		              addColumn: (SpStringTableColumn
				               title: 'object'
				               evaluated: [ :item | item object ifNil: [ '' ] ]);
		              whenModelChangedDo: [ actionList selectItem: nil ];
		              whenSelectionChangedDo: [ self updateSourceText ];
		              yourself.
	sourceText := (self newSourceWith: RMDGrammar new actionDefinition)
		              enabled: false;
		              editable: false;
		              highlights: Array new;
		              whenLastValidSyntaxNodeChangedDo: [ :syntaxNode |  ];
		              yourself.
	self updateRepositoryList
]

{ #category : #initialization }
RMDRepositoryBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Repository Browser'.
	aWindowPresenter initialExtent: 800 @ 400
]

{ #category : #operations }
RMDRepositoryBrowser >> removeRepository [

	self repository ifNotNil: [ :repository | 
		RMDRepositoryDirectory current remove: repository.
		self updateRepositoryList ]
]

{ #category : #accessing }
RMDRepositoryBrowser >> repository [
	^ repositoryList selection selectedItem
]

{ #category : #updating }
RMDRepositoryBrowser >> updateActionList [

	actionList items: (self repository
			 ifNotNil: [ :repository | repository actions ]
			 ifNil: [ #(  ) ])
]

{ #category : #updating }
RMDRepositoryBrowser >> updateRepositoryList [

	| repository |
	repository := self repository.
	repositoryList
		unselectAll;
		items: RMDRepositoryDirectory current repositories.
	(repositoryList items includes: repository) ifTrue: [ 
		repositoryList selectItem: repository ]
]

{ #category : #updating }
RMDRepositoryBrowser >> updateSourceText [

	self action
		ifNotNil: [ :action | sourceText syntaxNode: action ]
		ifNil: [ sourceText text: '' ]
]
