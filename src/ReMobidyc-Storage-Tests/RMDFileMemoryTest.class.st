Class {
	#name : #RMDFileMemoryTest,
	#superclass : #RMDMemoryTest,
	#category : #'ReMobidyc-Storage-Tests'
}

{ #category : #private }
RMDFileMemoryTest >> basePath [
	^ FileLocator localDirectory / 'ReMobidycTest'
]

{ #category : #private }
RMDFileMemoryTest >> createMemory [
	^ RMDFileMemory
		on:
			(self basePath
				ensureCreateDirectory;
				yourself)
]

{ #category : #private }
RMDFileMemoryTest >> destroyMemory [
	memory := nil.
	self basePath ensureDeleteAll
]
