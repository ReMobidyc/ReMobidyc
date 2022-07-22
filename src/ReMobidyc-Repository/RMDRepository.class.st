Class {
	#name : #RMDRepository,
	#superclass : #Object,
	#category : #'ReMobidyc-Repository'
}

{ #category : #'accessing-models' }
RMDRepository >> actionFileNamed: aString ifAbsent: errorBlock [
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
RMDRepository >> addAction: aRMDActionDefinitionNode named: aString [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> addIcon: aForm named: aString [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> addModel: aRMDSimulationModel named: aString [

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
RMDRepository >> isModifiable [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> modelFileNamed: aString ifAbsent: errorBlock [
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

{ #category : #'accessing-actions' }
RMDRepository >> removeActionNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> removeIconNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-models' }
RMDRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #'accessing-icons' }
RMDRepository >> renameIconNamed: aString to: anotherString ifAbsent: errorBlock [

	| form |
	form := self iconNamed: aString ifAbsent: [ ^ errorBlock value ].
	self addIcon: form named: anotherString.
	(self iconNamed: anotherString ifAbsent: [ nil ]) ifNotNil: [ 
		self removeIconNamed: aString ifAbsent: [ ^ errorBlock value ] ].
	^ form
]

{ #category : #accessing }
RMDRepository >> repositoryName [
	^ self subclassResponsibility
]
