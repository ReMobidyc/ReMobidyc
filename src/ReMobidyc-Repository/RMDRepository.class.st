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

{ #category : #'accessing-models' }
RMDRepository >> addModel: aRMDSimulationModel named: aString [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> icon [

	^ self subclassResponsibility
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

{ #category : #'accessing-models' }
RMDRepository >> removeModelNamed: aString ifAbsent: errorBlock [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> repositoryName [
	^ self subclassResponsibility
]
