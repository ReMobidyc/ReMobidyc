Class {
	#name : #RMDRepositoryIconsBrowser,
	#superclass : #RMDAbstractRepositoryBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #enumerating }
RMDRepositoryIconsBrowser class >> openToLoadDo: aBlock [

	<script:
	'RMDRepositoryIconsBrowser openToLoadDo: [ :form | form inspect ] '>
	super openToLoadDo: aBlock
]

{ #category : #adding }
RMDRepositoryIconsBrowser >> addItem [

	self repository ifNotNil: [ :repo | 
		| ref form |
		ref := UIManager default
			       chooseExistingFileReference: 'Choose a PNG file.'
			       extensions: #( 'png' )
			       path: FileLocator desktop
			       preview: #image.
		ref ifNil: [ ^ self ].
		ref isFile ifFalse: [ ^ self ].
		form := PNGReadWriter formFromFileNamed: ref.
		(UIManager default request: 'Enter a new name of the icon') 
			ifNotNil: [ :name | 
				repo addIcon: form named: name.
				self updateItemList.
				itemList selectItem: name ] ]
]

{ #category : #operations }
RMDRepositoryIconsBrowser >> editItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default
				 request: 'Rename ' , item , ' to'
				 initialAnswer: item) ifNotNil: [ :n | 
				n trim ifNotEmpty: [ :newName | 
					repo
						renameIcon: item
						ifAbsent: [ 
							UIManager default
								alert: item , ' does not exist.'
								title: 'Rename icon' ]
						to: newName
						ifPresent: [ 
							UIManager default
								alert: newName , ' already exists.'
								title: 'Rename icon' ].
					self updateItemList ] ] ] ]
]

{ #category : #accessing }
RMDRepositoryIconsBrowser >> file [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo iconFileNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : #private }
RMDRepositoryIconsBrowser >> getIcon: aString [

	^ self repository ifNotNil: [ :repo | 
		  repo iconNamed: aString ifAbsent: [ nil ] ]
]

{ #category : #initialization }
RMDRepositoryIconsBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Icons'
]

{ #category : #accessing }
RMDRepositoryIconsBrowser >> itemsInRepository [

	^ (self repository ifNotNil: #iconNames ifNil: [ #(  ) ]) asSortedCollection
]

{ #category : #actions }
RMDRepositoryIconsBrowser >> load [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo iconNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : #'instance creation' }
RMDRepositoryIconsBrowser >> newItemList [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  addColumn: (SpStringTableColumn title: '' evaluated: [ :item | 
					   | t |
					   t := item asText.
					   (self getIcon: item) ifNil: [ t makeAllColor: Color red ].
					   t ]);
		  addColumn:
			  (SpImageTableColumn title: 'icon' evaluated: [ :item | 
					   (self getIcon: item) ifNotNil: [ :form | 
							   (form extent x > 32 or: [ form extent y > 32 ]) ifTrue: [ 
									   form scaledToSize: 32 @ 32 ] ] ]);
		  yourself
]

{ #category : #removing }
RMDRepositoryIconsBrowser >> removeItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default confirm:
				 'Remove ' , item , ' from ' , repo name , ' repository?') 
				ifTrue: [ 
					repo removeIconNamed: item ifAbsent: [  ].
					self updateItemList ] ] ]
]

{ #category : #actions }
RMDRepositoryIconsBrowser >> save: aForm [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  ((repo actionNamed: item ifAbsent: [ nil ]) isNil or: [ 
				   UIManager default confirm:
					   'Overwrite ' , item , ' in ' , repo name , ' repository?' ]) 
				  ifTrue: [ repo addIcon: aForm named: item ] ] ]
]

{ #category : #updating }
RMDRepositoryIconsBrowser >> updateButtons [

	self repository
		ifNil: [ 
			removeRepositoryButton disable.
			newItemButton disable.
			removeItemButton disable ]
		ifNotNil: [ :repo | 
			removeRepositoryButton enable.
			repo isModifiable
				ifTrue: [ 
					newItemButton enable.
					removeItemButton enabled: self item notNil ]
				ifFalse: [ 
					newItemButton disable.
					removeItemButton disable ] ].
	self item ifNotNil: [ self enableOk ] ifNil: [ self disableOk ]
]

{ #category : #updating }
RMDRepositoryIconsBrowser >> updateDescriptionText [

	descriptionText text: ((self item ifNotNil: [ :item | 
			  (self getIcon: item)
				  ifNotNil: [ :form | 
				  form extent x printString , ' x ' , form extent y printString ]
				  ifNil: [ '' ] ]) ifNil: [ '' ])
]
