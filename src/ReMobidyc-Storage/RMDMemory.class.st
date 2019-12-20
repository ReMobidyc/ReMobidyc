Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#category : #'ReMobidyc-Storage'
}

{ #category : #accessing }
RMDMemory >> at: anInteger [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMemory >> at: anInteger put: aFloatOrInteger [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMemory >> tick [
	^ self subclassResponsibility
]
