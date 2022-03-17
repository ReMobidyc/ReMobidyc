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
		'isForSave'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAbstractRepositoryBrowser class >> defaultSpec [

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
				   add: (SpBoxLayout newVertical
						    add: #itemList;
						    add: (SpBoxLayout newHorizontal
								     add: #newItemButton width: self buttonHeight;
								     add: #removeItemButton width: self buttonHeight;
								     yourself)
						    expand: false;
						    yourself);
				   add: #descriptionText;
				   yourself);
		  yourself
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openForSave: anObject [

	| browser |
	browser := self new forSave.
	browser openDialogWithSpec okAction: [ 
		browser save: anObject ]
]

{ #category : #utilities }
RMDAbstractRepositoryBrowser class >> openToLoadDo: aBlock [

	| browser |
	browser := self new.
	browser openDialogWithSpec okAction: [ aBlock cull: browser load ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> addGit [

	^ self notYetImplemented
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
						  name: 'Git';
						  icon: Smalltalk ui icons git;
						  action: [ self addGit ] ] ];
		  yourself
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> disableOk [

	self withWindowDo: [ :window | 
		window buttons ifNotEmpty: [ :buttons | buttons first disable ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> editRepository [

	^ self notYetImplemented
]

{ #category : #private }
RMDAbstractRepositoryBrowser >> enableOk [

	self withWindowDo: [ :window | 
		window buttons ifNotEmpty: [ :buttons | buttons first enable ] ]
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> forLoad [

	self isForSave: false
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> forSave [

	self isForSave: true
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
	itemList := self newItemList
		            whenModelChangedDo: [ itemList selectItem: nil ];
		            whenSelectionChangedDo: [ 
			            self
				            updateButtons;
				            updateDescriptionText ].
	newItemButton := self newButton
		                 icon: self addIcon;
		                 action: [ self addItem ];
		                 disable;
		                 yourself.
	removeItemButton := self newButton
		                    icon: self removeIcon;
		                    action: [ self removeItem ];
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
	aWindowPresenter title: 'Repository Browser'.
	aWindowPresenter initialExtent: 800 @ 400
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> isForSave [
	^ isForSave
]

{ #category : #accessing }
RMDAbstractRepositoryBrowser >> isForSave: aBoolean [

	isForSave := aBoolean = true
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

{ #category : #'instance creation' }
RMDAbstractRepositoryBrowser >> newItemList [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> removeItem [

	^ self subclassResponsibility
]

{ #category : #operations }
RMDAbstractRepositoryBrowser >> removeRepository [

	self repository ifNotNil: [ :repository | 
		self repositoryDirectory remove: repository.
		self updateRepositoryList ]
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

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateButtons [

	self repository
		ifNil: [ 
			removeRepositoryButton disable.
			newItemButton disable.
			removeItemButton disable ]
		ifNotNil: [ :repo | 
			removeRepositoryButton enable.
			repo isModifiable
				ifTrue: [ 
					newItemButton enabled: isForSave = true.
					removeItemButton enabled: self item notNil ]
				ifFalse: [ 
					newItemButton disable.
					removeItemButton disable ] ].
	self item ifNotNil: [ self enableOk ] ifNil: [ self disableOk ]
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
		items: self repositoryDirectory repositories.
	(repositoryList items includes: repository) ifTrue: [ 
		repositoryList selectItem: repository ]
]

{ #category : #updating }
RMDAbstractRepositoryBrowser >> updateSourceText [

	self item
		ifNotNil: [ :action | descriptionText syntaxNode: action ]
		ifNil: [ descriptionText text: '' ]
]
