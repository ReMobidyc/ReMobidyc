Class {
	#name : 'RMDRepositoryDataBrowser',
	#superclass : 'RMDAbstractRepositoryBrowser',
	#category : 'ReMobidyc-Spec2-Browsers',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Browsers'
}

{ #category : 'enumerating' }
RMDRepositoryDataBrowser class >> openToLoadDo: aBlock [

	<script:
	'RMDRepositoryDataBrowser openToLoadDo: [ :fileReference | fileReference inspect ] '>
	super openToLoadDo: aBlock
]

{ #category : 'adding' }
RMDRepositoryDataBrowser >> addItem [

	self repository ifNotNil: [ :repo |
		| ref form |
		ref := UIManager default
			       chooseExistingFileReference: 'Choose a CSV file.'
			       extensions: #( 'csv' )
			       path: FileLocator desktop
			       preview: #text.
		ref ifNil: [ ^ self ].
		ref isFile ifFalse: [ ^ self ].
		(UIManager default
			 request: 'Enter a new name of the data'
			 initialAnswer: ref basename) ifNotNil: [ :name |
			repo addDataFile: ref named: name ifPresent: [
				(UIManager default confirm: name , ' already exists. Overwrite?')
					ifFalse: [ ^ self ] ].
			self updateItemList.
			itemList selectItem: name ] ]
]

{ #category : 'operations' }
RMDRepositoryDataBrowser >> editItem [

	self repository ifNotNil: [ :repo |
		self item ifNotNil: [ :item |
			(UIManager default
				 request: 'Rename ' , item , ' to'
				 initialAnswer: item) ifNotNil: [ :n |
				n trim ifNotEmpty: [ :newName |
					repo
						renameData: item
						ifAbsent: [
							UIManager default
								alert: item , ' does not exist.'
								title: 'Rename data' ]
						to: newName
						ifPresent: [
							UIManager default
								alert: newName , ' already exists.'
								title: 'Rename data' ].
					self updateItemList ] ] ] ]
]

{ #category : 'accessing' }
RMDRepositoryDataBrowser >> file [

	^ self repository ifNotNil: [ :repo |
		  self item ifNotNil: [ :item |
			  repo dataFileNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : 'accessing' }
RMDRepositoryDataBrowser >> itemsInRepository [

	^ self repository ifNotNil: #dataNames ifNil: [ #(  ) ]
]

{ #category : 'actions' }
RMDRepositoryDataBrowser >> load [

	^ self repository ifNotNil: [ :repo |
		  self item ifNotNil: [ :item |
			  repo dataFileNamed: item ifAbsent: [ nil ] ] ]
]

{ #category : 'instance creation' }
RMDRepositoryDataBrowser >> newItemList [

	^ self newTable
		  beSingleSelection;
		  beResizable;
		  showColumnHeaders;
		  addColumn: (SpStringTableColumn title: '' evaluated: #asText);
		  yourself
]

{ #category : 'removing' }
RMDRepositoryDataBrowser >> removeItem [

	self repository ifNotNil: [ :repo | 
		self item ifNotNil: [ :item | 
			(UIManager default confirm:
				 'Remove ' , item , ' from ' , repo name , ' repository?') 
				ifTrue: [ 
					repo removeDataNamed: item ifAbsent: [  ].
					self updateItemList ] ] ]
]

{ #category : 'actions' }
RMDRepositoryDataBrowser >> save: aFileReference [

	^ self repository ifNotNil: [ :repo |
		  self item ifNotNil: [ :item |
			  ((repo dataFileNamed: item ifAbsent: [ nil ]) isNil or: [
				   UIManager default confirm:
					   'Overwrite ' , item , ' in ' , repo name , ' repository?' ])
				  ifTrue: [
				  repo addDataFile: aFileReference named: item ifPresent: [  ] ] ] ]
]

{ #category : 'accessing' }
RMDRepositoryDataBrowser >> title [

	^ 'Data'
]

{ #category : 'updating' }
RMDRepositoryDataBrowser >> updateButtons [

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

{ #category : 'updating' }
RMDRepositoryDataBrowser >> updateDescriptionText [

	descriptionText text: ((self repository ifNotNil: [ :repo |
			  self item ifNotNil: [ :item |
				  repo dataFileNamed: item ifAbsent: [ nil ] ] ])
			 ifNotNil: [ :fileRef |
				 fileRef readStreamDo: [ :stream | (stream upTo: String lf) trim ] ]
			 ifNil: [ '' ])
]
