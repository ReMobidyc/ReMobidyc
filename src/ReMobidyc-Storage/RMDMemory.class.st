Class {
	#name : #RMDMemory,
	#superclass : #Object,
	#instVars : [
		'time',
		'deltaTime',
		'values',
		'oldValues',
		'old2Values'
	],
	#category : #'ReMobidyc-Storage'
}

{ #category : #accessing }
RMDMemory >> at: anInteger [
	^ self at: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsent: aBlock [
	^ values at: anInteger ifAbsent: aBlock
]

{ #category : #accessing }
RMDMemory >> at: anInteger ifAbsentPut: aBlock [
	^ self
		at: anInteger
		ifAbsent: [ self at: anInteger put: aBlock value ]
]

{ #category : #accessing }
RMDMemory >> at: anInteger put: aNumber [
	^ values at: anInteger put: aNumber
]

{ #category : #accessing }
RMDMemory >> delta2At: anInteger ifAbsent: errorBlock [
	^ (self oldAt: anInteger ifAbsent: [ ^ errorBlock value ]) * -2
		+ (self at: anInteger ifAbsent: [ ^ errorBlock value ])
		+ (self old2At: anInteger ifAbsent: [ ^ errorBlock value ])
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

{ #category : #accessing }
RMDMemory >> deltaTime [
	^ deltaTime
]

{ #category : #accessing }
RMDMemory >> deltaTime: aFloat [
	deltaTime := aFloat asFloat
]

{ #category : #accessing }
RMDMemory >> differential2At: anInteger [
	^ self differential2At: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> differential2At: anInteger ifAbsent: errorBlock [
	^ ((self oldAt: anInteger ifAbsent: [ ^ errorBlock value ]) * -2
		+ (self at: anInteger ifAbsent: [ ^ errorBlock value ])
		+ (self old2At: anInteger ifAbsent: [ ^ errorBlock value ]))
		/ deltaTime squared
]

{ #category : #accessing }
RMDMemory >> differentialAt: anInteger [
	^ self differentialAt: anInteger ifAbsent: [ ^ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> differentialAt: anInteger ifAbsent: errorBlock [
	^ ((self at: anInteger ifAbsent: [ ^ errorBlock value ])
		- (self oldAt: anInteger ifAbsent: [ ^ errorBlock value ]))
		/ deltaTime
]

{ #category : #timing }
RMDMemory >> fastSunrise [
	old2Values := oldValues.
	oldValues := values.
	values := Dictionary new
]

{ #category : #timing }
RMDMemory >> fastSunset [
	^ self sunset
]

{ #category : #initialization }
RMDMemory >> initialize [
	super initialize.
	deltaTime := 1.0.
	time := 0.
	values := Dictionary new.
	oldValues := Dictionary new.
	old2Values := Dictionary new
]

{ #category : #accessing }
RMDMemory >> old2At: anInteger [
	^ self old2At: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> old2At: anInteger ifAbsent: errorBlock [
	^ old2Values at: anInteger ifAbsent: errorBlock
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger [
	^ self oldAt: anInteger ifAbsent: [ KeyNotFound signal ]
]

{ #category : #accessing }
RMDMemory >> oldAt: anInteger ifAbsent: errorBlock [
	^ oldValues at: anInteger ifAbsent: errorBlock
]

{ #category : #'accessing-storage' }
RMDMemory >> readValuesForTime: anInteger [
	^ self subclassResponsibility
]

{ #category : #timing }
RMDMemory >> sunrise [
	oldValues := time >= 2
		ifTrue: [ self readValuesForTime: time - 2 ]
		ifFalse: [ Dictionary new ].
	oldValues := time >= 1
		ifTrue: [ self readValuesForTime: time - 1 ]
		ifFalse: [ Dictionary new ].
	values := self readValuesForTime: time
]

{ #category : #timing }
RMDMemory >> sunset [
	self writeValues: values forTime: time
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

{ #category : #'accessing-storage' }
RMDMemory >> writeValues: aDictionary forTime: anInteger [
	^ self subclassResponsibility
]
