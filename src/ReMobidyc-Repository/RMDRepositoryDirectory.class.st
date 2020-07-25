Class {
	#name : #RMDRepositoryDirectory,
	#superclass : #Object,
	#instVars : [
		'repositories'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'adding-removing' }
RMDRepositoryDirectory >> add: aRMDRepository [
	(repositories includes: aRMDRepository)
		ifFalse: [ repositories add: aRMDRepository ].
	^ aRMDRepository
]

{ #category : #initialization }
RMDRepositoryDirectory >> initialize [
	super initialize.
	repositories := OrderedCollection with: RMDBuiltinRepository new
]

{ #category : #accessing }
RMDRepositoryDirectory >> repositories [
	^ repositories
]
