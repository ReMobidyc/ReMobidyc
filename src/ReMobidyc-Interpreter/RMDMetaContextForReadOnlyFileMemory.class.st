Class {
	#name : 'RMDMetaContextForReadOnlyFileMemory',
	#superclass : 'RMDMetaContextForFileMemory',
	#category : 'ReMobidyc-Interpreter-Contexts',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Contexts'
}

{ #category : 'class access' }
RMDMetaContextForReadOnlyFileMemory >> memoryClass [

	^ RMDReadOnlyFileMemory
]
