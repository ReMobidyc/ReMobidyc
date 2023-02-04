Class {
	#name : #RMDIcebergRepositoryBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'icebergRepository',
		'incomingCommitList',
		'incomingChangeList',
		'refreshButton',
		'pullButton',
		'commitAndPushButton',
		'localChangeList',
		'checkoutButton'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDIcebergRepositoryBrowser class >> defaultLayout [

	^ SpPanedLayout newVertical
		  positionOfSlider: 0.2;
		  add: (SpBoxLayout newVertical
				   add: 'From upstream' expand: false;
				   add: #incomingCommitList;
				   yourself);
		  add: (SpPanedLayout newVertical
				   positionOfSlider: 0.5;
				   add: (SpBoxLayout newVertical
						    add: 'Incoming chnanges' expand: false;
						    add: #incomingChangeList;
						    add: (SpBoxLayout newHorizontal
								     add: #refreshButton expand: false;
								     add: #pullButton expand: false;
								     add: #commitAndPushButton expand: false;
								     add: #checkoutButton expand: false;
								     yourself)
						    height: self buttonHeight;
						    yourself);
				   add: (SpBoxLayout newVertical
						    add: 'Local changes' expand: false;
						    add: #localChangeList;
						    yourself))
]

{ #category : #'instance creation' }
RMDIcebergRepositoryBrowser class >> on: anIceLibgitRepository [

	^ self new
		  icebergRepository: anIceLibgitRepository;
		  yourself
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> basicPull [

	self icebergRepositoryDo: #pull
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> checkoutRemote: anIceRemoteCommit [
	self icebergRepositoryDo: [:repository |
		repository branch commit: anIceRemoteCommit]
]

{ #category : #operations }
RMDIcebergRepositoryBrowser >> commitAndPush [

	self icebergRepositoryDo: [ :repository | 
		repository fetch.
		repository branch upstream commit id ~= repository branch commit id 
			ifTrue: [ 
				^ UIManager default
					  alert: 'Pull the incoming commits before commit.'
					  title: 'Iceberg' ].
		(UIManager default request: 'Comment' initialAnswer: (', ' join:
				  (self localAdditions , self localModifications collect:
					   #pathString))) ifNotNil: [ :comment | 
			self commitAndPushWithMessage: comment.
			self icebergRepositoryChanged ] ]
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> commitAndPushWithMessage: aString [

	self icebergRepositoryDo: [ :repository | 
		repository
			addFileToIndex: RelativePath new;
			commitIndexWithMessage: aString
			andParents: { repository branch commit };
			push ]
]

{ #category : #'git-testing' }
RMDIcebergRepositoryBrowser >> conflictsWith: aRemoteCommit [

	^ (self incomingAdditions: aRemoteCommit)
	  , (self incomingModifications: aRemoteCommit)
	  , (self incomingDeletions: aRemoteCommit) intersection:
		  self localAdditions , self localModifications
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> fetch [

	self icebergRepositoryDo: #fetch
]

{ #category : #'git-testing' }
RMDIcebergRepositoryBrowser >> hasConflictsWith: aRemoteCommit [

	^ (self conflictsWith: aRemoteCommit) notEmpty
]

{ #category : #'git-testing' }
RMDIcebergRepositoryBrowser >> hasIncomingCommits [

	self icebergRepositoryDo: [ :repository | 
		^ repository branch upstream commit id
		  ~= repository branch commit id ].
	^ false
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepository [

	^ icebergRepository
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepository: aRMDIcebergRepository [

	icebergRepository := aRMDIcebergRepository.
	self icebergRepositoryChanged
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> icebergRepositoryChanged [

	self
		updateWindowTitle;
		updateIncomingCommitList;
		updateLocalChangeList;
		updatePullButton;
		updateCommitAndPushButton;
		updateCheckoutButton
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepositoryDo: aBlock [

	^ icebergRepository ifNotNil: aBlock
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepositoryDo: aBlock ifNil: nilBlock [

	^ icebergRepository ifNotNil: aBlock ifNil: nilBlock
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> incomingAdditions: aRemoteCommit [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local incoming |
			  local := repository branch commit fileSystem.
			  incoming := aRemoteCommit fileSystem.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (incoming / kind) isDirectory ifTrue: [ 
					  (incoming / kind) children do: [ :incomingRef | 
						  | basename |
						  basename := incomingRef basename.
						  basename first ~= $. ifTrue: [ 
							  | localRef |
							  localRef := local / kind / basename.
							  localRef exists ifFalse: [ 
								  changes nextPut: (RelativePath withAll: { 
											   kind.
											   basename }) ] ] ] ] ] ] ]
]

{ #category : #'git-enumerating' }
RMDIcebergRepositoryBrowser >> incomingCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository | 
		| headId |
		headId := repository branch commit id.
		repository branch upstream commits do: [ :commit | 
			commit id = headId ifTrue: [ ^ self ].
			aBlock cull: commit ] ]
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> incomingDeletions: aRemoteCommit [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local incoming |
			  local := repository branch commit fileSystem.
			  incoming := aRemoteCommit fileSystem.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (local / kind) isDirectory ifTrue: [ 
					  (local / kind) children do: [ :localRef | 
						  | basename |
						  basename := localRef basename.
						  basename first ~= $. ifTrue: [ 
							  | incomingRef |
							  incomingRef := incoming / kind / basename.
							  incomingRef exists ifFalse: [ 
								  changes nextPut: (RelativePath withAll: { 
											   kind.
											   basename }) ] ] ] ] ] ] ]
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> incomingModifications: aRemoteCommit [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local incoming changedPaths |
			  local := repository branch commit fileSystem.
			  incoming := aRemoteCommit fileSystem.
			  changedPaths := ((repository
				                    changedFilesBetween:
				                    repository workingCopy referenceCommit
				                    and: aRemoteCommit) collect: [ :string | 
				                   | index |
				                   index := string indexOf: $..
				                   index > 1 ifTrue: [ 
					                   | kind |
					                   kind := string copyFrom: 1 to: index - 1.
					                   (#( 'models' 'actions' 'icons' ) includes:
						                    kind) ifTrue: [ 
						                   | basename |
						                   basename := string allButFirst: index + 1.
						                   index := basename indexOf: $/.
						                   index > 0 ifTrue: [ 
							                   basename := basename
								                               copyFrom: 1
								                               to: index - 1 ].
						                   RelativePath withAll: { 
								                   kind.
								                   basename } ] ] ]) asSet.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (local / kind) isDirectory ifTrue: [ 
					  (local / kind) children do: [ :localRef | 
						  | basename |
						  basename := localRef basename.
						  basename first ~= $. ifTrue: [ 
							  | incomingRef |
							  incomingRef := incoming / kind / basename.
							  incomingRef exists ifTrue: [ 
								  | path |
								  path := RelativePath withAll: { 
										          kind.
										          basename }.
								  (changedPaths includes: path) ifTrue: [ 
									  changes nextPut: path ] ] ] ] ] ] ] ]
]

{ #category : #initialization }
RMDIcebergRepositoryBrowser >> initializePresenters [

	super initializePresenters.
	incomingCommitList := self newTable
		                      disable;
		                      beResizable;
		                      addColumn: ((SpStringTableColumn
				                        title: 'date'
				                        evaluated: [ :commit | 
					                        commit datetime printString ]) width: 100);
		                      addColumn:
			                      ((SpStringTableColumn
				                        title: 'author'
				                        evaluated: #author) width: 100);
		                      addColumn:
			                      (SpStringTableColumn
				                       title: 'comment'
				                       evaluated: [ :commit | 
					                       commit comment lines first
					                       , (commit comment lines size > 2
							                        ifTrue: [ '...' ]
							                        ifFalse: [ '' ]) ]);
		                      whenSelectionChangedDo: [ 
			                      self updateIncomingChangeList ];
		                      yourself.
	incomingChangeList := self newTable
		                      disable;
		                      beResizable;
		                      addColumn:
			                      ((SpStringTableColumn
				                        title: ''
				                        evaluated: #value) width: 30);
		                      addColumn: (SpStringTableColumn
				                       title: 'path'
				                       evaluated: [ :assoc | 
					                       '/' join: assoc key segments ]);
		                      yourself.
	refreshButton := self newButton
		                 disable;
		                 icon: self updateIcon;
		                 action: [ self icebergRepositoryChanged ];
		                 yourself.
	pullButton := self newButton
		              disable;
		              icon: self pullIcon;
		              action: [ self pull ];
		              yourself.
	commitAndPushButton := self newButton
		                       disable;
		                       icon: self pushIcon;
		                       action: [ self commitAndPush ];
		                       yourself.
	localChangeList := self newTable
		                   disable;
		                   beResizable;
		                   addColumn:
			                   ((SpStringTableColumn
				                     title: ''
				                     evaluated: #value) width: 30);
		                   addColumn: (SpStringTableColumn
				                    title: 'path'
				                    evaluated: [ :assoc | 
					                    '/' join: assoc key segments ]);
		                   yourself.
	checkoutButton := self newButton
		                  disable;
		                  icon: self versionsIcon;
		                  action: [ self openCommits ];
		                  yourself
]

{ #category : #initialization }
RMDIcebergRepositoryBrowser >> initializeWindow: aSpWindowPresenter [

	super initializeWindow: aSpWindowPresenter.
	aSpWindowPresenter initialExtent: 500 @ 600
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> localAdditions [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local head |
			  local := repository workingCopy fileSystem.
			  head := repository branch commit fileSystem.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (local / kind) isDirectory ifTrue: [ 
					  (local / kind) children do: [ :localRef | 
						  | basename |
						  basename := localRef basename.
						  basename first ~= $. ifTrue: [ 
							  | headRef |
							  headRef := head / kind / basename.
							  headRef exists ifFalse: [ 
								  changes nextPut: (RelativePath withAll: { 
											   kind.
											   basename }) ] ] ] ] ] ] ]
]

{ #category : #'git-enumerating' }
RMDIcebergRepositoryBrowser >> localCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository | 
		repository branch commits do: aBlock ]
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> localDeletions [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local head |
			  local := repository workingCopy fileSystem.
			  head := repository branch commit fileSystem.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (head / kind) isDirectory ifTrue: [ 
					  (head / kind) children do: [ :headRef | 
						  | basename |
						  basename := headRef basename.
						  basename first ~= $. ifTrue: [ 
							  | localRef |
							  localRef := local / kind / basename.
							  localRef exists ifFalse: [ 
								  changes nextPut: (RelativePath withAll: { 
											   kind.
											   basename }) ] ] ] ] ] ] ]
]

{ #category : #'git-conflicts' }
RMDIcebergRepositoryBrowser >> localModifications [

	^ Array streamContents: [ :changes | 
		  self icebergRepositoryDo: [ :repository | 
			  | local head |
			  local := repository workingCopy fileSystem.
			  head := repository branch commit fileSystem.
			  #( 'models' 'actions' 'icons' ) do: [ :kind | 
				  (local / kind) isDirectory ifTrue: [ 
					  (local / kind) children do: [ :localRef | 
						  | basename |
						  basename := localRef basename.
						  basename first ~= $. ifTrue: [ 
							  | headRef |
							  headRef := head / kind / basename.
							  headRef exists ifTrue: [ 
								  localRef creationTime > headRef creationTime ifTrue: [ 
									  changes nextPut: (RelativePath withAll: { 
												   kind.
												   basename }) ] ] ] ] ] ] ] ]
]

{ #category : #operations }
RMDIcebergRepositoryBrowser >> openCommits [
]

{ #category : #operations }
RMDIcebergRepositoryBrowser >> pull [

	incomingCommitList selectedItem ifNotNil: [ :commit | 
		(self hasConflictsWith: commit)
			ifTrue: [ 
				UIManager default
					alert:
					'The incoming commit conflicts with the current working copy.'
					title: 'Iceberg ' ]
			ifFalse: [ 
				self checkoutRemote: commit.
				self icebergRepositoryChanged ] ]
]

{ #category : #'git-enumerating' }
RMDIcebergRepositoryBrowser >> remoteCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository | 
		repository branch upstream commits do: aBlock ]
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> title [

	^ icebergRepository
		  ifNotNil: [ icebergRepository name ]
		  ifNil: [ 'IcebergRepositoryBrowser' ]
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateCheckoutButton [
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateCommitAndPushButton [

	commitAndPushButton enabled:
		(self hasIncomingCommits not and: [ localChangeList items notEmpty ])
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateIncomingChangeList [

	self icebergRepositoryDo: [ :repository | 
		incomingCommitList selectedItem ifNotNil: [ :remoteCommit | 
			^ incomingChangeList items:
				  (((self incomingAdditions: remoteCommit) collect: [ :path | 
					    path -> 'A' ])
				   ,
					   ((self incomingModifications: remoteCommit) collect: [ :path | 
						    path -> 'M' ])
				   , ((self incomingDeletions: remoteCommit) collect: [ :path | 
						    path -> 'D' ]) asSortedCollection: [ :less :more | 
					   less key <= more key ]) ] ].
	incomingChangeList items: #(  )
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateIncomingCommitList [

	self
		icebergRepositoryDo: [ :repository | 
			| commits |
			repository fetch.
			commits := Array streamContents: [ :stream | 
				           self incomingCommitsDo: [ :commit | 
					           stream nextPut: commit ] ].
			incomingCommitList
				items: commits;
				selectIndex: (commits ifEmpty: [ 0 ] ifNotEmpty: [ 1 ]) ]
		ifNil: [ incomingCommitList items: #(  ) ]
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateLocalChangeList [

	self icebergRepositoryDo: [ :repository | 
		^ localChangeList items:
			  ((self localAdditions collect: [ :path | path -> 'A' ])
			   , (self localModifications collect: [ :path | path -> 'M' ])
			   , (self localDeletions collect: [ :path | path -> 'D' ]) 
				   asSortedCollection: [ :less :more | less key <= more key ]) ].
	localChangeList items: #(  )
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updatePullButton [

	incomingCommitList selectedItem ifNotNil: [ :commit | 
		(self conflictsWith: commit) ifEmpty: [ 
			pullButton enable.
			^ self ] ].
	pullButton disable
]

{ #category : #updating }
RMDIcebergRepositoryBrowser >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self title ]
]

{ #category : #initialization }
RMDIcebergRepositoryBrowser >> windowIcon [

	^ self icebergIcon
]
