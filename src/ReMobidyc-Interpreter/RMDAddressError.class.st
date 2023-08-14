Class {
	#name : #RMDAddressError,
	#superclass : #RMDRuntimeError,
	#instVars : [
		'address'
	],
	#category : #'ReMobidyc-Interpreter-Exceptions'
}

{ #category : #'instance creation' }
RMDAddressError class >> on: aRMDSyntaxNode address: anInteger [

	^ (self on: aRMDSyntaxNode)
		  address: anInteger;
		  yourself
]

{ #category : #'instance creation' }
RMDAddressError class >> signal: aRMDSyntaxNode address: anInteger [

	^ (self on: aRMDSyntaxNode address: anInteger) signal
]

{ #category : #accessing }
RMDAddressError >> address [

	^ address
]

{ #category : #accessing }
RMDAddressError >> address: anInteger [

	address := anInteger
]

{ #category : #private }
RMDAddressError >> composeMessageText [

	^ node printString
	  ,
	  (address
		   ifNil: [ '' ]
		   ifNotNil: [ ' (' , address printString , ')' ])
	  , ' is not allocated.'
]
