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
	^ self at: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsent: errorBlock [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsentPut: aBlock [
	^ self
		at: anInteger
		ifAbsent: [ self at: anInteger put: aBlock value ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger put: aFloatOrInteger [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDMemory >> deltaAt: anInteger [
	^ self deltaAt: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> deltaAt: anInteger ifAbsent: errorBlock [
	^ (self at: anInteger ifAbsent: [ ^ errorBlock value ])
		- (self oldAt: anInteger ifAbsent: [ ^ errorBlock value ])
]

{ #category : #timing }
RMDMemory >> fastSunrise [
	^ self sunrise
]

{ #category : #timing }
RMDMemory >> fastSunset [
	^ self sunset
]

{ #category : #initialization }
RMDMemory >> initialize [
	super initialize.
	time := 0
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger [
	^ self oldAt: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger ifAbsent: errorBlock [
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
	self fastSunset.
	time := time + 1.
	self fastSunrise
]

{ #category : #timing }
RMDMemory >> time: anInteger [
	(anInteger isInteger and: [ anInteger >= 0 ])
		ifFalse: [ ^ SubscriptOutOfBounds signal ].
	self sunset.
	time := anInteger.
	self sunrise
]
