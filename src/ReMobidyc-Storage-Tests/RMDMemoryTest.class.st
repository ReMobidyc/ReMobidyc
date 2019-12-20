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
	self assert: (memory oldAt: 3) equals: 4
]

{ #category : #tests }
RMDMemoryTest >> testTick [
	memory at: 1 ifAbsentPut: [ 2 ].
	memory at: 3 ifAbsentPut: [ 4 ].
	self assert: (memory at: 1 ifAbsentPut: [ 5 ]) equals: 2.
	self assert: (memory at: 3 ifAbsentPut: [ 6 ]) equals: 4.
	memory tick.
	self assert: (memory oldAt: 1) equals: 2.
	self assert: (memory oldAt: 3) equals: 4.
	self assert: (memory at: 1 ifAbsentPut: [ 7 ]) equals: 7.
	self assert: (memory at: 3 ifAbsentPut: [ 8 ]) equals: 8.
	self assert: (memory at: 9 ifAbsentPut: [ 10 ]) equals: 10
]
