Class {
	#name : #RMDPatchColorMapRenderer,
	#superclass : #RMDPatchColorRenderer,
	#instVars : [
		'minAndColors'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDPatchColorMapRenderer class >> expression: aRMDExpression color: aColor [

	^ self new
		  expression: aRMDExpression;
		  color: aColor;
		  yourself
]

{ #category : #'instance creation' }
RMDPatchColorMapRenderer class >> expression: aRMDExpression color: aColor1 value: aRMDLiteral1 color: aColor2 [
	^ self new
		expression: aRMDExpression;
		color: aColor1;
		add: aColor2 at: aRMDLiteral1;
		yourself
]

{ #category : #'instance creation' }
RMDPatchColorMapRenderer class >> expression: aRMDExpression color: aColor1 value: aRMDLiteral1 color: aColor2 value: aRMDLiteral2 color: aColor3 [
	^ self new
		expression: aRMDExpression;
		color: aColor1;
		add: aColor2 at: aRMDLiteral1;
		add: aColor3 at: aRMDLiteral2;
		yourself
]

{ #category : #comparing }
RMDPatchColorMapRenderer >> = anObject [

	^ super = anObject and: [ 
		  minAndColors hasEqualElements: anObject minAndColors ]
]

{ #category : #'adding-removing' }
RMDPatchColorMapRenderer >> add: aColor at: aRMDLiteralNode [
	minAndColors add: aRMDLiteralNode -> aColor
]

{ #category : #accessing }
RMDPatchColorMapRenderer >> colorFrom: aNumber [
	self
		minAndColorsDo: [ :min :c | 
			min numeric <= aNumber
				ifTrue: [ ^ c ] ].
	^ color
]

{ #category : #comparing }
RMDPatchColorMapRenderer >> hash [

	^ super hash bitXor: minAndColors hash
]

{ #category : #initialization }
RMDPatchColorMapRenderer >> initialize [
	super initialize.
	minAndColors := SortedCollection
		sortBlock: [ :more :less | less key numeric <= more key numeric ]
]

{ #category : #private }
RMDPatchColorMapRenderer >> minAndColors [

	^ minAndColors
]

{ #category : #enumerating }
RMDPatchColorMapRenderer >> minAndColorsDo: aBlock [
	minAndColors
		do: [ :assoc | aBlock value: assoc key value: assoc value ]
]

{ #category : #accessing }
RMDPatchColorMapRenderer >> name [
	^ 'color map'
]

{ #category : #enumerating }
RMDPatchColorMapRenderer >> numberOfMinAndColors [
	^ minAndColors size
]

{ #category : #printing }
RMDPatchColorMapRenderer >> printOn: aStream [

	aStream nextPutAll: 'Patch -> map '.
	expression printOn: aStream.
	aStream
		nextPutAll: ' with ';
		nextPut: Character cr.
	self minAndColorsDo: [ :min :c | 
		aStream nextPutAll: '    '.
		self printColor: c on: aStream.
		aStream nextPutAll: ' if >= '.
		min printOn: aStream.
		aStream
			nextPutAll: ',';
			nextPut: Character cr ].
	aStream nextPutAll: '    '.
	self printColorOn: aStream.
	aStream
		nextPut: Character cr;
		nextPutAll: 'with '.
	borderWidth asInteger printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColor: borderColor on: aStream.
	aStream
		nextPutAll: ' grids.';
		cr
]

{ #category : #'adding-removing' }
RMDPatchColorMapRenderer >> removeAtIndex: anInteger ifAbsent: errorBlock [
	^ (anInteger between: 1 and: minAndColors size)
		ifTrue: [ minAndColors removeAt: anInteger ]
		ifFalse: [ errorBlock value ]
]
