Class {
	#name : #RMDRepositoryModelsBrowser,
	#superclass : #RMDAbstractRepositoryBrowser,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #utilities }
RMDRepositoryModelsBrowser class >> openForSave: aRMDSimulationModel [

	<script:
	'RMDRepositoryModelsBrowser openForSave: RMDSimulationModel sugarScape'>
	super openForSave: aRMDSimulationModel
]

{ #category : #utilities }
RMDRepositoryModelsBrowser class >> openToLoadDo: aBlock [

	<script:
	'RMDRepositoryModelsBrowser openToLoadDo: [ :model | model inspect ] '>
	super openToLoadDo: aBlock
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> addItem [

	(UIManager default request: 'Enter a new name of the model') 
		ifNotNil: [ :newItem | 
			itemList items: (itemList items copyWith: newItem).
			isForSave ifTrue: [ 
				itemList selectItem: newItem.
				^ self performOK ].
			self repository
				ifNotNil: [ :repository | 
					repository
						addModel: RMDSimulationModel new
						named: newItem
						ifPresent: [ 
							(UIManager default confirm:
								 newItem , ' already exists. Overwrite?') ifFalse: [ ^ self ] ].
					itemList selectItem: newItem ]
				ifNil: [ ^ self ] ]
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> editItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default
				 request: 'Rename ' , item , ' to'
				 initialAnswer: item) ifNotNil: [ :n | 
				n trim ifNotEmpty: [ :newName | 
					repo
						renameModel: item
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

{ #category : #operations }
RMDRepositoryModelsBrowser >> file [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo modelFileNamed: item ifPresent: #yourself ifAbsent: [ nil ] ] ]
]

{ #category : #private }
RMDRepositoryModelsBrowser >> getModel: aString [

	^ self repository ifNotNil: [ :repo | 
		  repo modelNamed: aString ifAbsent: [ nil ] ]
]

{ #category : #accessing }
RMDRepositoryModelsBrowser >> initialize [

	super initialize
]

{ #category : #accessing }
RMDRepositoryModelsBrowser >> itemsInRepository [

	^ (self repository ifNotNil: #modelNames ifNil: [ #(  ) ]) asSortedCollection
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> load [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  repo modelNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : #'instance creation' }
RMDRepositoryModelsBrowser >> newItemList [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  addColumn: (SpStringTableColumn evaluated: #asText);
		  yourself
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> removeItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default confirm:
				 'Remove ' , item , ' from ' , repo name , ' repository?') 
				ifTrue: [ 
					Cursor wait showWhile: [ 
						repo removeModelNamed: item ifAbsent: [  ] ].
					self updateItemList ] ] ]
]

{ #category : #operations }
RMDRepositoryModelsBrowser >> save: aRMDSimulationModel [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  ((repo modelNamed: item ifAbsent: [ nil ]) isNil or: [ 
				   UIManager default confirm:
					   'Overwrite ' , item , ' in ' , repo name , ' repository?' ]) 
				  ifTrue: [ 
				  repo addModel: aRMDSimulationModel named: item ifPresent: [  ] ] ] ]
]

{ #category : #initialization }
RMDRepositoryModelsBrowser >> title [
	^ 'Models'
]

{ #category : #updating }
RMDRepositoryModelsBrowser >> updateDescriptionText [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  descriptionText text:
				  (repo modelMetadataNamed: item ifAbsent: [ '' ]) asText ] ]
]
