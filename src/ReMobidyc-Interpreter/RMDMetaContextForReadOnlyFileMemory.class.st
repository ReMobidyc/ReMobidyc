Class {
	#name : #RMDMetaContextForReadOnlyFileMemory,
	#superclass : #RMDMetaContextForFileMemory,
	#category : #'ReMobidyc-Interpreter-Contexts'
}

{ #category : #'class access' }
RMDMetaContextForReadOnlyFileMemory >> memoryClass [

	^ RMDReadOnlyFileMemory
]
