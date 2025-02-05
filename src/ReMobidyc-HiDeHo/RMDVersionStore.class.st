Class {
	#name : 'RMDVersionStore',
	#superclass : 'HiDeStorage',
	#category : 'ReMobidyc-HiDeHo',
	#package : 'ReMobidyc-HiDeHo'
}

{ #category : 'class access' }
RMDVersionStore >> payloadClassFor: aHiDeMetadata [

	^ RMDModelVersion
]
