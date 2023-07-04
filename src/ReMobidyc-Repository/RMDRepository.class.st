Class {
	#name : #RMDRepository,
	#superclass : #Object,
	#category : #'ReMobidyc-Repository'
}

{ #category : #'accessing-actions' }
RMDRepository >> actionFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-actions' }
RMDRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #'accessing-actions' }
RMDRepository >> actionNames [
	^ self subclassResponsibility
]

{ #category : #'accessing-actions' }
RMDRepository >> actions [

	^ self actionNames
		  collect: [ :name | self actionNamed: name ifAbsent: [ nil ] ]
		  thenSelect: #notNil
]

{ #category : #'accessing-actions' }
RMDRepository >> addAction: aRMDActionDefinitionNode named: aString ifPresent: aBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-data' }
RMDRepository >> addDataFile: aForm named: aString ifPresent: aBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> addIcon: aForm named: aString ifPresent: aBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> addModel: aRMDSimulationModel named: aString ifPresent: presentBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-data' }
RMDRepository >> dataFileNamed: aString ifAbsent: errorBlock [

	^ self
		  dataFileNamed: aString
		  ifPresent: #yourself
		  ifAbsent: errorBlock
]

{ #category : #'accessing-data' }
RMDRepository >> dataFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-data' }
RMDRepository >> dataNames [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> icon [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> iconNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #'accessing-icons' }
RMDRepository >> iconNames [
	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> icons [

	^ self iconNames
		  collect: [ :name | self iconNamed: name ifAbsent: [ nil ] ]
		  thenSelect: #notNil
]

{ #category : #controlling }
RMDRepository >> ifModifiable: aBlock [

	^ self isModifiable
		  ifTrue: aBlock
		  ifFalse: [ nil ]
]

{ #category : #controlling }
RMDRepository >> ifNotModifiable: aBlock [

	^ self isModifiable
		  ifTrue: [ nil ]
		  ifFalse: aBlock
]

{ #category : #testing }
RMDRepository >> isIcebergRepository [

	^ false
]

{ #category : #testing }
RMDRepository >> isModifiable [

	^ self subclassResponsibility
]

{ #category : #testing }
RMDRepository >> isRunsRepository [

	^ false
]

{ #category : #'accessing-models' }
RMDRepository >> modelFileNamed: aString ifPresent: aBlock ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #'accessing-models' }
RMDRepository >> modelMetadataNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #'accessing-models' }
RMDRepository >> modelNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #'accessing-models' }
RMDRepository >> modelNames [
	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> models [

	^ self modelNames
		  collect: [ :name | self modelNamed: name ifAbsent: [ nil ] ]
		  thenSelect: #notNil
]

{ #category : #accessing }
RMDRepository >> name [

	^ self repositoryName
]

{ #category : #'accessing-actions' }
RMDRepository >> removeActionNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-data' }
RMDRepository >> removeDataNamed: aString ifAbsent: errorBlock [

	^ self
		  dataFileNamed: aString
		  ifPresent: #ensureDelete
		  ifAbsent: errorBlock
]

{ #category : #'accessing-icons' }
RMDRepository >> removeIconNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-actions' }
RMDRepository >> renameAction: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-data' }
RMDRepository >> renameData: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> renameIcon: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> renameModel: aString ifAbsent: absentBlock to: anotherString ifPresent: presentBlock [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> repositoryName [
	^ self subclassResponsibility
]
