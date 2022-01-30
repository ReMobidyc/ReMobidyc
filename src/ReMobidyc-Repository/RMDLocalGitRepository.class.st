Class {
	#name : #RMDLocalGitRepository,
	#superclass : #RMDLocalFileRepository,
	#category : #'ReMobidyc-Repository'
}

{ #category : #'instance creation' }
RMDLocalGitRepository class >> on: aFileReference name: aString clone: gitString [

	(LGitRepository on: aFileReference) clone: gitString.
	^ self on: aFileReference name: aString
]

{ #category : #accessing }
RMDLocalGitRepository >> icon [

	^ Smalltalk ui icons git
]
