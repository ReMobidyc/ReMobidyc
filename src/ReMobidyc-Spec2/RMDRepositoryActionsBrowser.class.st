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

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: #repositoryList expand: true;
				   add: (SpBoxLayout newHorizontal
						    add: #addRepositoryButton width: self buttonHeight;
						    add: #removeRepositoryButton width: self buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  add: (SpPanedLayout newVertical
				   add: #actionList;
				   add: #sourceText;
				   yourself);
		  yourself
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> action [

	^ actionList selection selectedItem
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addGit [

	^ self notYetImplemented
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addLocalDirectory [

	(UIManager default
		 chooseExistingFileReference: 'Repository Directory'
		 extensions: #(  )
		 path:
			 ((FileLocator documents / 'ReMobidyc') ensureCreateDirectory / '*')
				 absolutePath) ifNotNil: [ :ref | 
		(UIManager default
			 request: 'Repository Name'
			 initialAnswer: ref basename) ifNotNil: [ :name | 
			self repositoryDirectory add:
				(RMDLocalFileRepository on: ref name: name).
			self updateRepositoryList ] ]
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addRepository [

	self addRepositoryMenu openWithSpecAtPointer
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addRepositoryMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Local directory';
						  icon: Smalltalk ui icons open;
						  action: [ self addLocalDirectory ] ];
				  addItem: [ :item | 
					  item
						  name: 'Git';
						  icon: Smalltalk ui icons git;
						  action: [ self addGit ] ] ];
		  yourself
]

{ #category : #initialization }
RMDRepositoryActionsBrowser >> initializePresenters [

	super initializePresenters.
	repositoryList := self newList
		                  beSingleSelection;
		                  whenModelChangedDo: [ 
			                  repositoryList selectItem: nil ];
		                  whenSelectionChangedDo: [ 
			                  self
				                  updateButtons;
				                  updateActionList ];
		                  display: [ :item | item repositoryName ];
		                  displayIcon: [ :item | item icon ];
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
		self repositoryDirectory remove: repository.
		self updateRepositoryList ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> repository [

	^ [ repositoryList selection selectedItem ]
		  on: Error
		  do: [ :ex | ex return: nil ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> repositoryDirectory [

	^ RMDRepositoryDirectory current
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateActionList [

	actionList items: (self repository
			 ifNotNil: [ :repository | repository actions ]
			 ifNil: [ #(  ) ])
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateButtons [

	self repository
		ifNil: [ removeRepositoryButton disable ]
		ifNotNil: [ removeRepositoryButton enable ]
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateRepositoryList [

	| repository |
	repository := self repository.
	repositoryList
		unselectAll;
		items: self repositoryDirectory repositories.
	(repositoryList items includes: repository) ifTrue: [ 
		repositoryList selectItem: repository ]
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateSourceText [

	self action
		ifNotNil: [ :action | sourceText syntaxNode: action ]
		ifNil: [ sourceText text: '' ]
]
