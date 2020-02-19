Class {
	#name : #RMDMemoryTest,
	#superclass : #TestCase,
	#instVars : [
		'memory'
	],
	#category : #'ReMobidyc-Storage-Tests'
}

{ #category : #testing }
RMDMemoryTest class >> isAbstract [
	^ self name = #RMDMemoryTest
]

{ #category : #private }
RMDMemoryTest >> createMemory [
	^ self subclassResponsibility
]

{ #category : #private }
RMDMemoryTest >> destroyMemory [
	^ self subclassResponsibility
]

{ #category : #running }
RMDMemoryTest >> setUp [
	memory := self createMemory
]

{ #category : #running }
RMDMemoryTest >> tearDown [
	self destroyMemory
]

{ #category : #tests }
RMDMemoryTest >> testAt [
	memory at: 1 put: 2.
	self assert: (memory at: 1) equals: 2.
	self should: [ memory at: 3 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testAtIfAbsent [
	memory at: 1 put: 2.
	self assert: (memory at: 1 ifAbsent: [ 3 ]) equals: 2.
	self assert: (memory at: 2 ifAbsent: [ 3 ]) equals: 3.
	memory at: 2 put: 4.
	self deny: (memory at: 2 ifAbsent: [ 3 ]) equals: 3.
	self assert: (memory at: 2 ifAbsent: [ 3 ]) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testAtIfAbsentPut [
	memory at: 1 ifAbsentPut: [ 2 ].
	self assert: (memory at: 1) equals: 2.
	memory at: 1 ifAbsentPut: [ 3 ].
	self deny: (memory at: 1) equals: 3.
	self assert: (memory at: 1) equals: 2.
	memory at: 2 ifAbsentPut: [ 4 ].
	self assert: (memory at: 2) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testAtPut [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testDeltaAt [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 3 put: 6;
		at: 7 put: 8.
	self assert: (memory deltaAt: 1) equals: 5 - 2.
	self assert: (memory deltaAt: 3) equals: 6 - 4.
	self should: [ memory deltaAt: 7 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testDeltaAtIfabsent [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 3 put: 6;
		at: 7 put: 8.
	self assert: (memory deltaAt: 1) equals: 5 - 2.
	self assert: (memory deltaAt: 1 ifAbsent: [ 9 ]) equals: 5 - 2.
	self assert: (memory deltaAt: 3) equals: 6 - 4.
	self assert: (memory deltaAt: 3 ifAbsent: [ 10 ]) equals: 6 - 4.
	self should: [ memory deltaAt: 7 ] raise: KeyNotFound.
	self assert: (memory deltaAt: 7 ifAbsent: [ 11 ]) equals: 11
]

{ #category : #tests }
RMDMemoryTest >> testNextAt [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1) equals: 2.
	self should: [ memory nextAt: 3 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testNextAtIfAbsent [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1 ifAbsent: [ 3 ]) equals: 2.
	self assert: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 3.
	memory nextAt: 2 put: 4.
	self deny: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 3.
	self assert: (memory nextAt: 2 ifAbsent: [ 3 ]) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNextAtIfAbsentPut [
	memory nextAt: 1 put: 2.
	self assert: (memory nextAt: 1 ifAbsentPut: [ 3 ]) equals: 2.
	memory nextAt: 1 ifAbsentPut: [ 4 ].
	self deny: (memory nextAt: 1) equals: 4.
	self assert: (memory nextAt: 1) equals: 2.
	memory nextAt: 2 ifAbsentPut: [ 4 ].
	self assert: (memory nextAt: 2) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNextAtPut [
	memory nextAt: 1 put: 2.
	memory nextAt: 3 put: 4.
	self assert: (memory nextAt: 1) equals: 2.
	self assert: (memory nextAt: 3) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testNextDeltaAtAdd [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		at: 5 put: 6;
		nextDeltaAt: 1 add: 7;
		nextDeltaAt: 3 add: 8;
		nextDeltaAt: 1 add: 9;
		tick.
	self assert: (memory at: 1) equals: 2 + 7 + 9.
	self assert: (memory at: 3) equals: 4 + 8.
	self should: [ memory nextDeltaAt: 10 ] raise: KeyNotFound.
	memory
		nextDeltaAt: 3 add: 11;
		tick.
	self assert: (memory at: 1) equals: 2 + 7 + 9.
	self assert: (memory at: 3) equals: 4 + 8 + 11
]

{ #category : #tests }
RMDMemoryTest >> testOldAt [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 3 put: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self should: [ memory oldAt: 7 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testOldAtIfAbsent [
	memory
		at: 1 put: 2;
		at: 3 put: 4;
		tick;
		at: 1 put: 5;
		at: 6 put: 7.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 1 ifAbsent: [ 8 ]) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self assert: (memory oldAt: 3 ifAbsent: [ 9 ]) equals: 4.
	self should: [ memory oldAt: 6 ] raise: KeyNotFound.
	self assert: (memory oldAt: 6 ifAbsent: [ 10 ]) equals: 10
]

{ #category : #tests }
RMDMemoryTest >> testTick [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	memory nextAt: 5 put: 6.
	memory nextAt: 3 put: 7.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 4.
	self assert: (memory nextAt: 5) equals: 6.
	self should: [ memory at: 5 ] raise: KeyNotFound.
	memory tick.
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 7.
	self assert: (memory at: 5) equals: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self should: [ memory oldAt: 5 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testTime [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	memory nextAt: 1 put: 5.
	memory tick.
	memory at: 3 put: 6.
	memory nextAt: 1 put: 7.
	memory tick.
	memory at: 8 put: 9.
	memory time: 1.
	self assert: (memory at: 1) equals: 5.
	self assert: (memory at: 3) equals: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	memory time: 2.
	self assert: (memory at: 1) equals: 7.
	self assert: (memory at: 3 ifAbsent: [ 10 ]) equals: 4.
	self assert: (memory at: 8) equals: 9.
	self assert: (memory oldAt: 1) equals: 5.
	self assert: (memory oldAt: 3) equals: 6.
	self assert: (memory oldAt: 8 ifAbsent: [ 11 ]) equals: 11
]
