Class {
	#name : #RMDOnMemoryTest,
	#superclass : #RMDMemoryTest,
	#category : #'ReMobidyc-Storage-Tests'
}

{ #category : #private }
RMDOnMemoryTest >> createMemory [
	^ RMDOnMemory new
]

{ #category : #private }
RMDOnMemoryTest >> destroyMemory [
	memory := nil
]

{ #category : #tests }
RMDOnMemoryTest >> testChangeStorageCapacityTo [

	memory
		nextAt: 1 put: 1;
		tick;
		nextAt: 1 put: 2;
		tick;
		nextAt: 1 put: 3;
		time: 0.
	memory changeStorageCapacityTo: 2.
	memory time: 0.
	self assert: (memory at: 1) equals: 1.
	memory time: 1.
	self assert: (memory at: 1) equals: 2.
	self should: [ memory time: 3 ] raise: SubscriptOutOfBounds
]
