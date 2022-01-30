Class {
	#name : #RMDRepository,
	#superclass : #Object,
	#category : #'ReMobidyc-Repository'
}

{ #category : #accessing }
RMDRepository >> actionNamed: aString ifAbsent: errorBlock [
	^ self subclassResponsibility 
]

{ #category : #accessing }
RMDRepository >> actionNames [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> actions [

	^ self actionNames
		  collect: [ :name | self actionNamed: name ifAbsent: [ nil ] ]
		  thenSelect: #notNil
]

{ #category : #testing }
RMDRepository >> isModifiable [

	^ self subclassResponsibility
]

{ #category : #accessing }
RMDRepository >> repositoryName [
	^ self subclassResponsibility
]
