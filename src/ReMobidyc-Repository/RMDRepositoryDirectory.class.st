Class {
	#name : #RMDRepositoryDirectory,
	#superclass : #Object,
	#instVars : [
		'repositories'
	],
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'sole instance' }
RMDRepositoryDirectory class >> current [
	<script: 'RMDRepositoryDirectory current inspect'>
	^ current ifNil: [ current := self new ]
]

{ #category : #'adding-removing' }
RMDRepositoryDirectory >> add: aRMDRepository [
	(repositories includes: aRMDRepository)
		ifFalse: [ repositories add: aRMDRepository ].
	^ aRMDRepository
]

{ #category : #initialization }
RMDRepositoryDirectory >> initialize [

	super initialize.
	repositories := OrderedCollection
		                with: RMDBuiltinRepository new
		                with: RMDLocalFileRepository default
]

{ #category : #'adding-removing' }
RMDRepositoryDirectory >> remove: aRMDRepository [
	repositories remove: aRMDRepository ifAbsent: [].
	^ aRMDRepository
]

{ #category : #accessing }
RMDRepositoryDirectory >> repositories [
	^ repositories
]
