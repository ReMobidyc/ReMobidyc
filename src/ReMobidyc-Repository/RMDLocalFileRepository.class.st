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

{ #category : #'class access' }
RMDLocalFileRepository class >> classFor: aFileReference [

	^ (aFileReference / '.git') isDirectory
		  ifTrue: [ RMDLocalGitRepository ]
		  ifFalse: [ RMDLocalFileRepository ]
]

{ #category : #'instance creation' }
RMDLocalFileRepository class >> default [

	^ self on:
		  (FileLocator documents / 'ReMobidyc') ensureCreateDirectory name: 'Local default'
]

{ #category : #'instance creation' }
RMDLocalFileRepository class >> on: aFileReference name: aString [

	^ (self classFor: aFileReference) new
		  directory: aFileReference;
		  name: aString;
		  yourself
]

{ #category : #'accessing-actions' }
RMDLocalFileRepository >> actionNamed: aString ifAbsent: errorBlock [

	| ref action |
	ref := self actionsDirectory / aString withExtension: 'rmd'.
	ref isFile ifFalse: [ ^ errorBlock value ].
	action := RMDGrammar new actionDefinition end parse: ref contents.
	action isPetit2Failure ifTrue: [ ^ errorBlock value ].
	^ action
]

{ #category : #'accessing-actions' }
RMDLocalFileRepository >> actionNames [

	^ (self actionsDirectory filesMatching: '*.rmd') collect: #basename
]

{ #category : #'accessing-actions' }
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

{ #category : #accessing }
RMDLocalFileRepository >> icon [

	^ Smalltalk ui icons open
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

{ #category : #'accessing-models' }
RMDLocalFileRepository >> modelNamed: aString ifAbsent: errorBlock [

	| ref |
	ref := self modelsDirectory / aString.
	ref isDirectory ifFalse: [ ^ errorBlock value ].
	^ RMDSimulationModel importModel: ref ifError: errorBlock
]

{ #category : #'accessing-models' }
RMDLocalFileRepository >> modelNames [

	^ self modelsDirectory directoryNames reject: [ :dirname | 
		  dirname isEmpty or: [ dirname first = $. ] ]
]

{ #category : #'accessing-models' }
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
