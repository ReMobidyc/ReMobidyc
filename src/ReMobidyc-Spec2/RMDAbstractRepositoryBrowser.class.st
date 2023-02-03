Class {
	#name : #RMDAbstractRepositoryBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'addRepositoryButton',
		'editRepositoryButton',
		'removeRepositoryButton',
		'repositoryList',
		'itemList',
		'descriptionText',
		'newItemButton',
		'removeItemButton',
		'editItemButton',
		'exportItemButton',
		'isForSave',
		'updateItemListButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDAbstractRepositoryBrowser class >> defaultLayout [

	^ SpPanedLayout newHorizontal
		  positionOfSlider: 0.3;
		  add: (SpBoxLayout newVertical
				   add: #repositoryList expand: true;
				   add: (SpBoxLayout newHorizontal
						    add: #addRepositoryButton width: self buttonHeight;
						    add: #removeRepositoryButton width: self buttonHeight;
						    add: #editRepositoryButton width: self buttonHeight;
						    yourself)
				   expand: false;
				   yourself);
		  add: (SpPanedLayout newVertical
				   add: (SpBoxLayout newVertical
						    add: #itemList;
						    add: (SpBoxLayout newHorizontal
								     add: #updateItemListButton width: self buttonHeight;
								     add: #newItemButton width: self buttonHeight;
								     add: #removeItemButton width: self buttonHeight;
								     add: #editItemButton width: self buttonHeight;
								     add: #exportItemButton width: self buttonHeight;
								     yourself)
						    expand: false;
						    yourself);
				   add: #descriptionText;
				   yourself);
		  yourself
]

{ #category : #testing }
RMDAbstractRepositoryBrowser class >> isAbstract [

	^ true
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openForSave: anObject [

	| browser |
	browser := self new forSave.
	browser openDialog okAction: [ browser save: anObject ]
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openForSave: anObject do: aBlock [

	| browser |
	browser := self new forSave.
	browser openDialog okAction: [ 
		browser save: anObject.
		aBlock cull: anObject cull: browser ]
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openForSave: anObject ifAccepted: aBlock [

	| browser |
	browser := self new forSave.
	browser openDialog okAction: [ 
		browser save: anObject.
		aBlock cull: browser file cull: browser ]
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openForSave: anObject title: aString [

	| browser |
	browser := self new forSave.
	browser openDialog
		title: aString;
		okAction: [ browser save: anObject ]
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openToLoadDo: aBlock [

	| browser |
	browser := self new.
	browser openDialog okAction: [ 
		aBlock cull: browser load cull: browser ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> addIcebergRepository [

	| repos |
	repos := (IceRepository repositories
		          select: [ :repo | self isValidNewRepository: repo ]
		          thenCollect: #name) asOrderedCollection.
	(FileLocator localDirectory / 'iceberg') directories do: [ :ownerRef | 
		ownerRef directories do: [ :repoRef | 
			(self isValidGitLocalForNewRepository: repoRef) ifTrue: [ 
				repos add: '(' , ownerRef basename , '/' , repoRef basename , ')' ] ] ].
	repos ifEmpty: [ 
		^ UIManager default alert: 'No re:mobidyc repository on Iceberg.' ].
	(UIManager default
		 chooseFrom: repos
		 title: 'Select an Iceberg repository') ifNotNil: [ :index | 
		(repos at: index ifAbsent: [ nil ]) ifNotNil: [ :repo | 
			(UIManager default request: 'Repository Name' initialAnswer: repo) 
				ifNotNil: [ :name | 
					self repositoryDirectory add: (repo first = $(
							 ifTrue: [ 
								 | pair o r |
								 pair := repo substrings: '/'.
								 o := pair first copyWithoutFirst.
								 r := pair second copyWithout: $).
								 RMDIcebergRepository
									 onLocalGit: FileLocator localDirectory / 'iceberg' / o / r
									 name: name ]
							 ifFalse: [ RMDIcebergRepository on: repo name: name ]).
					self updateRepositoryList ] ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> addItem [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> addLocalDirectory [

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
RMDAbstractRepositoryBrowser >> addRepository [

	self addRepositoryMenu openWithSpecAtPointer
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> addRepositoryMenu [

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
						  name: 'Iceberg';
						  icon: RMDIcebergRepository icon;
						  action: [ self addIcebergRepository ] ];
				  addItem: [ :item | 
					  item
						  name: 'Import Iceberg';
						  icon: RMDIcebergRepository icon;
						  action: [ 
							  (Smalltalk at: #IceTipRepositoriesBrowser) new openDialog 
								  okAction: [ [self addIcebergRepository] fork ] ] ] ];
		  yourself
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> disableOk [

	self withWindowDo: [ :window | 
		window isDialog ifTrue: [ 
			window buttons ifNotEmpty: [ :buttons | buttons first disable ] ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> editItem [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> editRepository [

	self repository ifNotNil: #edit.
	repositoryList refresh
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> enableOk [

	self withWindowDo: [ :window | 
		window isDialog ifTrue: [ 
			window buttons ifNotEmpty: [ :buttons | buttons first enable ] ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> exportItem [

	self load ifNotNil: [ :item | 
		self class openForSave: item title: 'Export ' , self item , 'to...' ]
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> file [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> forLoad [

	self isForSave: false
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> forSave [

	self isForSave: true
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> getRepositories [

	^ self repositoryDirectory repositories
]

{ #category : #initialization }
RMDAbstractRepositoryBrowser >> initialize [

	super initialize.
	isForSave := false
]

{ #category : #initialization }
RMDAbstractRepositoryBrowser >> initializePresenters [

	super initializePresenters.
	repositoryList := self newList
		                  beSingleSelection;
		                  whenModelChangedDo: [ 
			                  repositoryList selectItem: nil ];
		                  whenSelectionChangedDo: [ 
			                  self
				                  updateButtons;
				                  updateItemList ];
		                  display: [ :item | item repositoryName ];
		                  displayIcon: [ :item | item icon ];
		                  yourself.
	addRepositoryButton := self newButton
		                       icon: self addIcon;
		                       action: [ self addRepository ];
		                       help: 'Add a new repository';
		                       yourself.
	removeRepositoryButton := self newButton
		                          icon: self removeIcon;
		                          action: [ self removeRepository ];
		                          help: 'Remove the selected repository';
		                          disable;
		                          yourself.
	editRepositoryButton := self newButton
		                        icon: self editIcon;
		                        action: [ self editRepository ];
		                        help:
			                        'Edit the configuration of the selected repository';
		                        disable;
		                        yourself.
	itemList := self newItemList
		            whenModelChangedDo: [ itemList selectItem: nil ];
		            whenSelectionChangedDo: [ 
			            self
				            updateButtons;
				            updateDescriptionText ].
	updateItemListButton := self newButton
		                        icon: self updateIcon;
		                        action: [ self updateItemList ];
		                        disable;
		                        yourself.
	newItemButton := self newButton
		                 icon: self addIcon;
		                 action: [ self addItem ];
		                 help: 'Add a new item in the repository';
		                 disable;
		                 yourself.
	removeItemButton := self newButton
		                    icon: self removeIcon;
		                    action: [ self removeItem ];
		                    help:
			                    'Remove the selected item from the repository';
		                    disable;
		                    yourself.
	editItemButton := self newButton
		                  icon: self editIcon;
		                  action: [ self editItem ];
		                  help:
			                  'Rename the selected item from the repository';
		                  disable;
		                  yourself.
	exportItemButton := self newButton
		                    icon: self exportIcon;
		                    action: [ self exportItem ];
		                    help:
			                    'Export the selected item to another repository';
		                    disable;
		                    yourself.
	descriptionText := self newText
		                   enabled: false;
		                   editable: false;
		                   yourself.
	self whenWindowChanged: [ self disableOk ].
	self updateRepositoryList
]

{ #category : #initialization }
RMDAbstractRepositoryBrowser >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 800 @ 400
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> isForSave [
	^ isForSave
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> isForSave: aBoolean [

	isForSave := aBoolean = true.
	self updateButtons
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> isValidGitLocalForNewRepository: aFileReference [

	^ ((aFileReference / 'models') exists or: [ 
		   (aFileReference / 'actions') exists or: [ 
			   (aFileReference / 'icons') exists ] ]) and: [ 
		  (IceRepository repositories contains: [ :iceRepogitory | 
			   iceRepogitory location = aFileReference ]) not ]
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> isValidNewRepository: anIceRepository [

	^ anIceRepository isReMobidycRepository and: [ 
		  (RMDRepositoryDirectory current repositories contains: [ :repo | 
			   repo isIcebergRepository and: [ 
				   repo icebergRepository = anIceRepository ] ]) not ]
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> item [

	^ itemList selection selectedItem
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> itemsInRepository [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> load [

	^ self subclassResponsibility
]

{ #category : #widgets }
RMDAbstractRepositoryBrowser >> newItemList [

	^ self subclassResponsibility
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> performOK [

	self withWindowDo: [ :window | 
		window buttons ifNotEmpty: [ :buttons | buttons first click ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> removeItem [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> removeRepository [

	self repository ifNotNil: [ :repository | 
		(UIManager default confirm: 'Remove ' , repository name , '?') 
			ifTrue: [ 
				self repositoryDirectory remove: repository.
				self updateRepositoryList ] ]
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> repository [

	^ [ repositoryList selection selectedItem ]
		  on: Error
		  do: [ :ex | ex return: nil ]
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> repositoryDirectory [

	^ RMDRepositoryDirectory current
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> save: anObject [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> title [

	^ 'Repository Browser'
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateButtons [

	self repository
		ifNil: [ 
			removeRepositoryButton disable.
			editRepositoryButton disable.
			updateItemListButton disable.
			newItemButton disable.
			editItemButton disable ]
		ifNotNil: [ :repo | 
			removeRepositoryButton enable.
			editRepositoryButton enable.
			updateItemListButton enable.
			repo isModifiable
				ifTrue: [ 
					newItemButton enabled: true.
					removeItemButton enabled: self item notNil.
					editItemButton enabled: self item notNil ]
				ifFalse: [ 
					newItemButton disable.
					removeItemButton enabled: repo isRunsRepository.
					editItemButton disable ] ].
	self item
		ifNotNil: [ 
			exportItemButton enable.
			self enableOk ]
		ifNil: [ 
			exportItemButton disable.
			self disableOk ]
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateDescriptionText [

	^ self subclassResponsibility
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateItemList [

	itemList items: self itemsInRepository
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateRepositoryList [

	| repository |
	repository := self repository.
	repositoryList
		unselectAll;
		items: self getRepositories.
	(repositoryList items includes: repository) ifTrue: [ 
		repositoryList selectItem: repository ]
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateSourceText [

	self item
		ifNotNil: [ :action | descriptionText syntaxNode: action ]
		ifNil: [ descriptionText text: '' ]
]
