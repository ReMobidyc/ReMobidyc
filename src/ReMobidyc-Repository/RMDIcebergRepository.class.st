Class {
	#name : #RMDIcebergRepository,
	#superclass : #RMDAbstractFileRepository,
	#instVars : [
		'icebergRepositoryName'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #icons }
RMDIcebergRepository class >> icon [

	^ Smalltalk ui icons iconNamed: #komitterSmalltalkhubRemote
]

{ #category : #'instance creation' }
RMDIcebergRepository class >> on: aString name: anotherString [

	^ self new
		  icebergRepositoryName: aString;
		  name: anotherString;
		  yourself
]

{ #category : #'instance creation' }
RMDIcebergRepository class >> onLocalGit: aFileReference name: anotherString [

	^ self new
		  icebergRepositoryName:
			  (self reactivateExistingLocal: aFileReference) name;
		  name: anotherString;
		  yourself
]

{ #category : #utilities }
RMDIcebergRepository class >> reactivateExistingLocal: aFileReference [

	^ (IceRepositoryCreator new
		   repository: nil;
		   location: aFileReference;
		   createRepository)
		  register;
		  yourself
]

{ #category : #'instance creation' }
RMDIcebergRepository class >> standardModels [

	^ self on: 'StandardModels' name: 'Standard Models'
]

{ #category : #accessing }
RMDIcebergRepository >> basicDirectory [

	^ self icebergRepository ifNotNil: #location
]

{ #category : #accessing }
RMDIcebergRepository >> icebergRepository [

	^ IceRepository repositories
		  detect: [ :repo | repo name = icebergRepositoryName ]
		  ifNone: [ nil ]
]

{ #category : #accessing }
RMDIcebergRepository >> icebergRepositoryName [

	^ icebergRepositoryName
]

{ #category : #accessing }
RMDIcebergRepository >> icebergRepositoryName: aString [

	icebergRepositoryName := aString
]

{ #category : #accessing }
RMDIcebergRepository >> icon [

	^ self class icon
]

{ #category : #testing }
RMDIcebergRepository >> isIcebergRepository [

	^ true
]

{ #category : #testing }
RMDIcebergRepository >> isModifiable [

	self directoryDo: [ :directory | ^ true ].
	^ false
]
