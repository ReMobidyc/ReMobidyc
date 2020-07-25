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
RMDRepository >> name [
	^ self subclassResponsibility
]
