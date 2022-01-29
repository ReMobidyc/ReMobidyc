Class {
	#name : #RMDRepositoryActionsBrowser,
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
RMDRepositoryActionsBrowser class >> defaultSpec [

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
RMDRepositoryActionsBrowser >> action [

	^ actionList selection selectedItem
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addRepository [
	^ self notYetImplemented
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> editRepository [
	^ self notYetImplemented
]

{ #category : #initialization }
RMDRepositoryActionsBrowser >> initializePresenters [

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
RMDRepositoryActionsBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Repository Browser'.
	aWindowPresenter initialExtent: 800 @ 400
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> removeRepository [

	self repository ifNotNil: [ :repository | 
		RMDRepositoryDirectory current remove: repository.
		self updateRepositoryList ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> repository [
	^ repositoryList selection selectedItem
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateActionList [

	actionList items: (self repository
			 ifNotNil: [ :repository | repository actions ]
			 ifNil: [ #(  ) ])
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateRepositoryList [

	| repository |
	repository := self repository.
	repositoryList
		unselectAll;
		items: RMDRepositoryDirectory current repositories.
	(repositoryList items includes: repository) ifTrue: [ 
		repositoryList selectItem: repository ]
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateSourceText [

	self action
		ifNotNil: [ :action | sourceText syntaxNode: action ]
		ifNil: [ sourceText text: '' ]
]
