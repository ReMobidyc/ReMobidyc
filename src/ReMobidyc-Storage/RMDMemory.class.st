Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#instVars : [
		'time'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #accessing }
RMDMemory >> at: anInteger [
	^ self at: anInteger ifAbsentPut: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsentPut: aBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMemory >> at: anInteger put: aFloatOrInteger [
	^ self subclassResponsibility
]

{ #category : #initialization }
RMDMemory >> initialize [
	super initialize.
	time := 0
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger [
	^ self subclassResponsibility
]

{ #category : #timing }
RMDMemory >> sunrise [
	^ self subclassResponsibility
]

{ #category : #timing }
RMDMemory >> sunset [
	^ self subclassResponsibility
]

{ #category : #timing }
RMDMemory >> tick [
	self sunset.
	time := time + 1.
	self sunrise
]
