Class {
	#name : #RMDAbstractFileRepository,
	#superclass : #RMDRepository,
	#instVars : [
		'name'
	],
	#category : #'ReMobidyc-Repository'
}

{ #category : #testing }
RMDAbstractFileRepository class >> isAbstract [
		
	^ self == RMDAbstractFileRepository
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> actionFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	self actionsDirectoryDo: [ :actionsDirectory | 
		| ref |
		ref := actionsDirectory / aString withExtension: 'rmd'.
		^ ref isFile
			  ifTrue: [ aBlock cull: ref ]
			  ifFalse: errorBlock ].
	^ errorBlock value
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> actionNamed: aString ifAbsent: errorBlock [

	| action |
	^ self
		  actionFileNamed: aString
		  ifPresent: [ :ref | 
			  action := RMDGrammar new actionDefinition end parse: ref contents.
			  action isPetit2Failure
				  ifTrue: errorBlock
				  ifFalse: [ action ] ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> actionNames [

	self actionsDirectoryDo: [ :actionsDirectory | 
		^ ((actionsDirectory filesMatching: '*.rmd') collect: #basename)
			  asSortedCollection ].
	^ Array new
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> actionsDirectoryDo: aBlock [

	^ self directoryDo: [ :directory | 
		  aBlock value: (directory / 'actions') ensureCreateDirectory ]
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> addAction: aRMDActionDefinitionNode named: aString ifPresent: aBlock [

	self actionsDirectoryDo: [ :actionsDirectory | 
		| ref |
		ref := actionsDirectory / aString withExtension: 'rmd'.
		ref exists ifTrue: [ aBlock cull: ref ].
		ref ensureDelete writeStreamDo: [ :stream | 
			aRMDActionDefinitionNode printOn: stream ] ]
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> addIcon: aForm named: aString ifPresent: aBlock [

	self iconsDirectoryDo: [ :iconsDirectory | 
		| ref |
		ref := iconsDirectory / aString withExtension: 'png'.
		ref exists ifTrue: [ aBlock ifNotNil: [ aBlock cull: ref ] ].
		PNGReadWriter putForm: aForm onFileNamed: ref ensureDelete ]
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> addModel: aRMDSimulationModel named: aString ifPresent: presentBlock [

	self modelsDirectoryDo: [ :modelsDirectory | 
		| ref |
		ref := modelsDirectory / aString.
		ref exists ifTrue: [ 
			presentBlock ifNotNil: [ presentBlock cull: ref ] ].
		^ aRMDSimulationModel exportModel: ref ensureDeleteAll ]
]

{ #category : #privatee }
RMDAbstractFileRepository >> basicDirectory [

	^ self subclassResponsibility
]

{ #category : #controling }
RMDAbstractFileRepository >> directoryDo: aBlock [

	self basicDirectory ifNotNil: [ :directory | 
		directory isDirectory ifTrue: [ ^ aBlock value: directory ] ].
	^ nil
]

{ #category : #testing }
RMDAbstractFileRepository >> hasEditMenu [

	^ true
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> iconFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	self iconsDirectoryDo: [ :iconsDirectory | 
		| ref |
		ref := iconsDirectory / aString withExtension: 'png'.
		ref isFile ifTrue: [ ^ aBlock cull: ref ] ].
	^ errorBlock value
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> iconNamed: aString ifAbsent: errorBlock [

	^ self
		  iconFileNamed: aString
		  ifPresent: [ :fileRef | PNGReadWriter formFromFileNamed: fileRef ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> iconNames [

	self iconsDirectoryDo: [ :iconDirectory | 
		^ ((iconDirectory filesMatching: '*.png') collect: #basename)
			  asSortedCollection ].
	^ Array new
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> iconsDirectoryDo: aBlock [

	^ self directoryDo: [ :directory | 
		  aBlock cull: (directory / 'icons') ensureCreateDirectory ]
]

{ #category : #testing }
RMDAbstractFileRepository >> isModifiable [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> modelFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	self modelsDirectoryDo: [ :modelsDirectory | 
		| ref |
		ref := modelsDirectory / aString.
		^ ref isDirectory
			  ifTrue: [ aBlock cull: ref ]
			  ifFalse: errorBlock ].
	^ errorBlock value
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> modelMetadataNamed: aString ifAbsent: errorBlock [

	^ self
		  modelFileNamed: aString
		  ifPresent: [ :fileRef | 
			  RMDSimulationModel importMetadata: fileRef ifError: errorBlock ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> modelNamed: aString ifAbsent: errorBlock [

	^ self
		  modelFileNamed: aString
		  ifPresent: [ :fileRef | 
			  RMDSimulationModel importModel: fileRef ifError: errorBlock ]
		  ifAbsent: errorBlock
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> modelNames [

	self modelsDirectoryDo: [ :modelsDirectory | 
		^ (modelsDirectory directoryNames reject: [ :dirname | 
			   dirname isEmpty or: [ dirname first = $. ] ]) asSortedCollection ].
	^ Array new
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> modelsDirectoryDo: aBlock [

	^ self directoryDo: [ :directory | 
		  aBlock cull: (directory / 'models') ensureCreateDirectory ]
]

{ #category : #accessing }
RMDAbstractFileRepository >> name [
	^ name
]

{ #category : #accessing }
RMDAbstractFileRepository >> name: aString [

	name := aString
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> removeActionNamed: aString ifAbsent: errorBlock [

	^ self
		  actionFileNamed: aString
		  ifPresent: #ensureDelete
		  ifAbsent: errorBlock
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> removeIconNamed: aString ifAbsent: errorBlock [

	^ self
		  iconFileNamed: aString
		  ifPresent: #ensureDelete
		  ifAbsent: errorBlock
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	self modelsDirectoryDo: [ :modelsDirectory | 
		| ref |
		ref := modelsDirectory / aString.
		^ ref isDirectory
			  ifTrue: [ ref ensureDeleteAll ]
			  ifFalse: errorBlock ].
	^ errorBlock value
]

{ #category : #'accessing-actions' }
RMDAbstractFileRepository >> renameAction: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	aString = anotherString ifTrue: [ ^ self ].
	self
		actionFileNamed: aString
		ifPresent: [ :fileRef | 
			self
				actionFileNamed: anotherString
				ifPresent: [ :ref | presentBlock value ]
				ifAbsent: [ fileRef renameTo: anotherString , '.rmd' ] ]
		ifAbsent: absentBlock
]

{ #category : #'accessing-icons' }
RMDAbstractFileRepository >> renameIcon: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	aString = anotherString ifTrue: [ ^ self ].
	self
		iconFileNamed: aString
		ifPresent: [ :fileRef | 
			self
				iconFileNamed: anotherString
				ifPresent: presentBlock
				ifAbsent: [ fileRef renameTo: anotherString , '.png' ] ]
		ifAbsent: absentBlock
]

{ #category : #'accessing-models' }
RMDAbstractFileRepository >> renameModel: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	aString = anotherString ifTrue: [ ^ self ].
	^ self
		  modelFileNamed: aString
		  ifPresent: [ :fileRef | 
			  self
				  modelFileNamed: anotherString
				  ifPresent: presentBlock
				  ifAbsent: [ fileRef renameTo: anotherString ] ]
		  ifAbsent: absentBlock
]

{ #category : #accessing }
RMDAbstractFileRepository >> repositoryName [

	self directoryDo: [ :directory | ^ name ].
	^ (name , ' (broken)') asText makeAllColor: Color red
]
