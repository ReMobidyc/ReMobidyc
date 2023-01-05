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

{ #category : #accessing }
RMDIcebergRepository >> basicDirectory [

	^ self icebergRepository ifNotNil: #location
]

{ #category : #'repository urls' }
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
RMDIcebergRepository >> isModifiable [

	^ true
]
