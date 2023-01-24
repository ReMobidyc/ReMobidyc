Class {
	#name : #RMDRepositoryActionsBrowser,
	#superclass : #RMDAbstractRepositoryBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #utilities }
RMDRepositoryActionsBrowser class >> openForSave: aRMDActionDefinitionNode [

	<script:
	'RMDRepositoryActionsBrowser openForSave: RMDActionDefinitionNode template'>
	super openForSave: aRMDActionDefinitionNode
]

{ #category : #utilities }
RMDRepositoryActionsBrowser class >> openToLoadDo: aBlock [

	<script:
	'RMDRepositoryActionsBrowser openToLoadDo: [ :action | action inspect ] '>
	super openToLoadDo: aBlock
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> addItem [

	(UIManager default request: 'Enter a new name of the action') 
		ifNotNil: [ :name | 
			| newItem |
			newItem := name.
			(newItem endsWith: '.rmd') ifFalse: [ newItem := newItem , '.rmd' ].
			self repository
				ifNotNil: [ :repository | 
					repository
						addAction:
						(RMDActionDefinitionNode name: (newItem withoutSuffix: '.rmd'))
						named: newItem
						ifPresent: [ 
							(UIManager default confirm:
								 newItem , ' already exists. Overwrite?') ifFalse: [ ^ self ] ] ]
				ifNil: [ ^ self ].
			itemList items: (itemList items copyWith: newItem).
			itemList selectItem: newItem.
			isForSave ifTrue: [ self performOK ] ]
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> editItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default
				 request: 'Rename ' , item , ' to'
				 initialAnswer: item) ifNotNil: [ :n | 
				n trim ifNotEmpty: [ :newName | 
					repo
						renameAction: item
						ifAbsent: [ 
							UIManager default
								alert: item , ' does not exist.'
								title: 'Rename action' ]
						to: newName
						ifPresent: [ 
							UIManager default
								alert: newName , ' already exists.'
								title: 'Rename action' ].
					self updateItemList ] ] ] ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> file [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo actionFileNamed: item ifPresent: #yourself ifAbsent: [ nil ] ] ]
]

{ #category : #private }
RMDRepositoryActionsBrowser >> getAction: aString [

	^ self repository ifNotNil: [ :repo | 
		  repo actionNamed: aString ifAbsent: [ nil ] ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> itemsInRepository [

	^ (self repository ifNotNil: #actionNames ifNil: [ #(  ) ]) asSortedCollection
]

{ #category : #private }
RMDRepositoryActionsBrowser >> load [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo actionNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : #'instance creation' }
RMDRepositoryActionsBrowser >> newItemList [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  addColumn: (SpStringTableColumn title: '' evaluated: [ :item | 
					   | t |
					   t := item asText.
					   (self getAction: item) ifNil: [ t makeAllColor: Color red ].
					   t ]);
		  addColumn: (SpStringTableColumn
				   title: 'verb'
				   evaluated: [ :item | 
					   (self getAction: item) ifNotNil: #identifier ifNil: [ '' ] ]);
		  addColumn: (SpStringTableColumn
				   title: 'object'
				   evaluated: [ :item | 
					   ((self getAction: item) ifNotNil: #object) ifNil: [ '' ] ]);
		  yourself
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> removeItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default confirm:
				 'Remove ' , item , ' from ' , repo name , ' repository?') 
				ifTrue: [ 
					repo removeActionNamed: item ifAbsent: [  ].
					self updateItemList ] ] ]
]

{ #category : #operations }
RMDRepositoryActionsBrowser >> save: aRMDActionDefinitionNode [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  ((repo actionNamed: item ifAbsent: [ nil ]) isNil or: [ 
				   UIManager default confirm:
					   'Overwrite ' , item , ' in ' , repo name , ' repository?' ]) 
				  ifTrue: [ 
					  repo
						  addAction: aRMDActionDefinitionNode
						  named: item
						  ifPresent: [  ] ] ] ]
]

{ #category : #accessing }
RMDRepositoryActionsBrowser >> title [

	^ 'Actions'
]

{ #category : #updating }
RMDRepositoryActionsBrowser >> updateDescriptionText [

	descriptionText text: ((self item ifNotNil: [ :item | 
			  (self getAction: item) ifNotNil: #printString ]) ifNil: [ '' ])
]
