Class {
	#name : #RMDLocalFileRepository,
	#superclass : #RMDAbstractFileRepository,
	#instVars : [
		'directory',
		'modifiable'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #'instance creation' }
RMDLocalFileRepository class >> default [

	^ self on:
		  (FileLocator documents / 'ReMobidyc') ensureCreateDirectory name: 'Local default'
]

{ #category : #'instance creation' }
RMDLocalFileRepository class >> on: aFileReference name: aString [

	^ self new
		  directory: aFileReference;
		  name: aString;
		  yourself
]

{ #category : #privatee }
RMDLocalFileRepository >> basicDirectory [

	^ directory
]

{ #category : #accessing }
RMDLocalFileRepository >> beModifiable [

	^ self modifiable: true
]

{ #category : #accessing }
RMDLocalFileRepository >> beReadOnly [

	^ self modifiable: false
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
RMDLocalFileRepository >> icon [

	^ Smalltalk ui icons iconNamed: #open
]

{ #category : #initialization }
RMDLocalFileRepository >> initialize [
	super initialize.
	modifiable := true
]

{ #category : #testing }
RMDLocalFileRepository >> isModifiable [

	modifiable = true ifFalse: [ ^ false ].
	self directoryDo: [ :dir | ^ true ].
	^ false
]

{ #category : #accessing }
RMDLocalFileRepository >> modifiable [

	^ modifiable
]

{ #category : #accessing }
RMDLocalFileRepository >> modifiable: aBoolean [

	modifiable := aBoolean
]
