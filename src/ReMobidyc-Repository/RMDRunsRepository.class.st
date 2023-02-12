Class {
	#name : #RMDRunsRepository,
	#superclass : #RMDRepository,
	#classInstVars : [
		'current'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #accessing }
RMDRunsRepository class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : #accessing }
RMDRunsRepository class >> runsDirectory [

	^ (FileLocator documents / 'ReMobidyc' / 'runs')
		  ensureCreateDirectory
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> actionFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> actionNamed: aString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> actionNames [

	^ Array new
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> addAction: aRMDActionDefinitionNode named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-icons' }
RMDRunsRepository >> addIcon: aForm named: aString ifPresent: aBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-models' }
RMDRunsRepository >> addModel: aRMDSimulationModel named: aString ifPresent: presentBlock [

	^ self shouldNotImplement
]

{ #category : #accessing }
RMDRunsRepository >> icon [

	^ Smalltalk ui icons iconNamed: #open
]

{ #category : #'accessing-icons' }
RMDRunsRepository >> iconNamed: aString ifAbsent: errorBlock [

	^ errorBlock value
]

{ #category : #'accessing-icons' }
RMDRunsRepository >> iconNames [

	^ Array new
]

{ #category : #testing }
RMDRunsRepository >> isModifiable [

	^ false
]

{ #category : #testing }
RMDRunsRepository >> isRunsRepository [

	^ true
]

{ #category : #'accessing-models' }
RMDRunsRepository >> modelFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	| ref |
	ref := self runsDirectory / aString.
	^ ref isDirectory
		  ifTrue: [ aBlock cull: ref ]
		  ifFalse: errorBlock
]

{ #category : #'accessing-models' }
RMDRunsRepository >> modelMetadataNamed: aString ifAbsent: errorBlock [

	^ self
		  modelFileNamed: aString
		  ifPresent: [ :fileRef | 
			  RMDSimulationModel importMetadata: fileRef ifError: errorBlock ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-models' }
RMDRunsRepository >> modelNamed: aString ifAbsent: errorBlock [

	^ self
		  modelFileNamed: aString
		  ifPresent: [ :fileRef | 
			  RMDSimulationModel importModel: fileRef ifError: errorBlock ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-models' }
RMDRunsRepository >> modelNames [

	^ ((self runsDirectory directories select: [ :dir | 
		    dir basename first ~= $. ]) asSortedCollection: [ :newer :older | 
		   newer modificationTime >= older modificationTime ]) collect:
		  #basename
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> removeActionNamed: aString ifAbsent: errorBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-icons' }
RMDRunsRepository >> removeIconNamed: aString ifAbsent: errorBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-models' }
RMDRunsRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	| ref |
	ref := self runsDirectory / aString.
	^ ref isDirectory
		  ifTrue: [ ref ensureDeleteAll ]
		  ifFalse: errorBlock
]

{ #category : #'accessing-actions' }
RMDRunsRepository >> renameAction: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-icons' }
RMDRunsRepository >> renameIcon: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self shouldNotImplement
]

{ #category : #'accessing-models' }
RMDRunsRepository >> renameModel: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self shouldNotImplement
]

{ #category : #accessing }
RMDRunsRepository >> repositoryName [

	^ 'Runs'
]

{ #category : #accessing }
RMDRunsRepository >> runsDirectory [

	^ self class runsDirectory
]
