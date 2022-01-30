Class {
	#name : #RMDLocalFileRepository,
	#superclass : #RMDRepository,
	#instVars : [
		'directory',
		'name',
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

{ #category : #accessing }
RMDLocalFileRepository >> actionNamed: aString ifAbsent: errorBlock [

	| ref action |
	ref := self actionsDirectory / aString withExtension: 'rmd'.
	ref isFile ifFalse: [ ^ errorBlock value ].
	action := RMDGrammar new actionDefinition end parse: ref contents.
	action isPetit2Failure ifTrue: [ ^ errorBlock value ].
	^ action
]

{ #category : #accessing }
RMDLocalFileRepository >> actionNames [

	^ (self actionsDirectory filesMatching: '*.rmd') collect: #basename
]

{ #category : #accessing }
RMDLocalFileRepository >> actionsDirectory [

	^ (self directory / 'actions') ensureCreateDirectory
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

{ #category : #initialization }
RMDLocalFileRepository >> initialize [
	super initialize.
	modifiable := true
]

{ #category : #testing }
RMDLocalFileRepository >> isModifiable [

	^ modifiable = true
]

{ #category : #accessing }
RMDLocalFileRepository >> modelsDirectory [

	^ (self directory / 'models') ensureCreateDirectory
]

{ #category : #accessing }
RMDLocalFileRepository >> modifiable [

	^ modifiable
]

{ #category : #accessing }
RMDLocalFileRepository >> modifiable: aBoolean [

	modifiable := aBoolean
]

{ #category : #accessing }
RMDLocalFileRepository >> name [
	^ name
]

{ #category : #accessing }
RMDLocalFileRepository >> name: aString [

	name := aString
]

{ #category : #accessing }
RMDLocalFileRepository >> repositoryName [

	^ name
]
