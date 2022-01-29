Class {
	#name : #RMDLocalFileRepository,
	#superclass : #RMDRepository,
	#instVars : [
		'directory'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'instance creation' }
RMDLocalFileRepository class >> default [
	^ self on: FileLocator documents / 'ReMobidyc'
]

{ #category : #'instance creation' }
RMDLocalFileRepository class >> on: aFileReference [

	^ self new
		  directory: aFileReference;
		  yourself
]

{ #category : #accessing }
RMDLocalFileRepository >> actionsDirectory [
	^ self directory / 'actions'
]

{ #category : #accessing }
RMDLocalFileRepository >> agentsDirectory [
	^ self directory / 'agents'
]

{ #category : #accessing }
RMDLocalFileRepository >> directory [

	^ directory
]

{ #category : #accessing }
RMDLocalFileRepository >> directory: aFileReference [

	directory := aFileReference asFileReference
]

{ #category : #accessing }
RMDLocalFileRepository >> modelsDirectory [
	^ self directory / 'models'
]
