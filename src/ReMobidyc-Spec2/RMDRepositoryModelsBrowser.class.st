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
		itemList selectItem: newItem.
		isForSave ifTrue: [ self performOK ] ]
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
RMDRepositoryModelsBrowser >> exportItem [

	self item ifNotNil: [ :item | 
		(self repository modelNamed: item ifAbsent: [ nil ]) ifNotNil: [ 
			:model | 
			| repos |
			repos := (RMDRepositoryDirectory current repositories select:
				          #isModifiable) copyWithout: self repository.
			(UIManager default
				 chooseFrom: (repos collect: #name)
				 title: 'Export to') ifNotNil: [ :index | 
				(repos at: index ifAbsent: [ nil ]) ifNotNil: [ :repo | 
					repo addModel: model named: item ifPresent: [ 
						(UIManager default confirm: item , ' already exists. Overwrite?') 
							ifFalse: [ ^ self ] ] ] ] ] ]
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

{ #category : #initialization }
RMDRepositoryModelsBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: 'Models'
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
					repo removeModelNamed: item ifAbsent: [  ].
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

{ #category : #updating }
RMDRepositoryModelsBrowser >> updateDescriptionText [

	^ self repository ifNotNil: [ :repo | 
		  self item ifNotNil: [ :item | 
			  descriptionText text:
				  (repo modelMetadataNamed: item ifAbsent: [ '' ]) asText ] ]
]
