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

{ #category : #'system startup' }
RMDMemoryTest >> setUp [
	memory := self createMemory
]

{ #category : #'system startup' }
RMDMemoryTest >> tearDown [
	self destroyMemory
]

{ #category : #tests }
RMDMemoryTest >> testAtIfAbsent [
	memory at: 1 put: 2.
	self assert: (memory at: 1 ifAbsent: [ 3 ]) equals: 2.
	memory at: 1 ifAbsentPut: [ 4 ].
	self deny: (memory at: 1) equals: 4.
	self assert: (memory at: 1) equals: 2.
	memory at: 2 ifAbsentPut: [ 4 ].
	self assert: (memory at: 2) equals: 4
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
	self assert: (memory at: 1) equals: 2.
	self assert: (memory at: 3) equals: 4.
	memory tick.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self should: [ memory oldAt: 5 ] raise: KeyNotFound.
	self should: [ memory at: 1 ] raise: KeyNotFound.
	self should: [ memory at: 3 ] raise: KeyNotFound.
	self should: [ memory at: 5 ] raise: KeyNotFound
]

{ #category : #tests }
RMDMemoryTest >> testTime [
	memory at: 1 put: 2.
	memory at: 3 put: 4.
	memory tick.
	memory at: 1 put: 5.
	memory at: 3 put: 6.
	memory tick.
	memory at: 1 put: 7.
	memory at: 8 put: 9.
	memory time: 1.
	self assert: (memory at: 1) equals: 5.
	self assert: (memory at: 3) equals: 6.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	memory time: 2.
	self assert: (memory at: 1) equals: 7.
	self assert: (memory at: 3 ifAbsent: [ 10 ]) equals: 10.
	self assert: (memory at: 8) equals: 9.
	self assert: (memory oldAt: 1) equals: 5.
	self assert: (memory oldAt: 3) equals: 6.
	self assert: (memory oldAt: 8 ifAbsent: [ 11 ]) equals: 11
]
