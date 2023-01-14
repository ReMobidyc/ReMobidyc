Class {
	#name : #RMDIcebergRepositoryBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'icebergRepository',
		'pullButton',
		'commitAndPushButton',
		'checkoutButton',
		'logList'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> checkoutRemote: anIceRemoteCommit [
	self icebergRepositoryDo: [:repository |
		repository branch commit: anIceRemoteCommit]
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

{ #category : #'git-enumerating' }
RMDIcebergRepositoryBrowser >> commitsDo: aBlock [

	self icebergRepositoryDo: [ :repository | 
		repository branch commits do: aBlock ]
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> fetch [

	self icebergRepositoryDo: #fetch
]

{ #category : #'git-testing' }
RMDIcebergRepositoryBrowser >> hasCommitsToPull [

	self icebergRepositoryDo: [ :repository | 
		^ repository branch head ~= repository workingCopy referenceCommit ].
	^ false
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepository [

	^ icebergRepository
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepository: aRMDIcebergRepository [

	icebergRepository := aRMDIcebergRepository
]

{ #category : #accessing }
RMDIcebergRepositoryBrowser >> icebergRepositoryDo: aBlock [

	^ icebergRepository ifNotNil: aBlock
]

{ #category : #'git-operations' }
RMDIcebergRepositoryBrowser >> pull [

	self icebergRepositoryDo: #pull
]

{ #category : #'git-enumerating' }
RMDIcebergRepositoryBrowser >> remoteCommitsDo: aBlock [

	self icebergRepositoryDo: [ :repository | 
		repository branch upstream commits do: aBlock ]
]
