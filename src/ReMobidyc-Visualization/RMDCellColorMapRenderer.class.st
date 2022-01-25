Class {
	#name : #RMDCellColorMapRenderer,
	#superclass : #RMDCellColorRenderer,
	#instVars : [
		'minAndColors'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellColorMapRenderer class >> expression: aRMDExpression color: aColor [

	^ self new
		  expression: aRMDExpression;
		  color: aColor;
		  yourself
]

{ #category : #'instance creation' }
RMDCellColorMapRenderer class >> expression: aRMDExpression color: aColor1 value: aRMDLiteral1 color: aColor2 [
	^ self new
		expression: aRMDExpression;
		color: aColor1;
		add: aColor2 at: aRMDLiteral1;
		yourself
]

{ #category : #'instance creation' }
RMDCellColorMapRenderer class >> expression: aRMDExpression color: aColor1 value: aRMDLiteral1 color: aColor2 value: aRMDLiteral2 color: aColor3 [
	^ self new
		expression: aRMDExpression;
		color: aColor1;
		add: aColor2 at: aRMDLiteral1;
		add: aColor3 at: aRMDLiteral2;
		yourself
]

{ #category : #'adding-removing' }
RMDCellColorMapRenderer >> add: aColor at: aRMDLiteralNode [
	minAndColors add: aRMDLiteralNode -> aColor
]

{ #category : #accessing }
RMDCellColorMapRenderer >> colorFrom: aNumber [
	self
		minAndColorsDo: [ :min :c | 
			min numeric <= aNumber
				ifTrue: [ ^ c ] ].
	^ color
]

{ #category : #initialization }
RMDCellColorMapRenderer >> initialize [
	super initialize.
	minAndColors := SortedCollection
		sortBlock: [ :more :less | less key numeric <= more key numeric ]
]

{ #category : #enumerating }
RMDCellColorMapRenderer >> minAndColorsDo: aBlock [
	minAndColors
		do: [ :assoc | aBlock value: assoc key value: assoc value ]
]

{ #category : #accessing }
RMDCellColorMapRenderer >> name [
	^ 'color map'
]

{ #category : #enumerating }
RMDCellColorMapRenderer >> numberOfMinAndColors [
	^ minAndColors size
]

{ #category : #printing }
RMDCellColorMapRenderer >> printOn: aStream [

	aStream nextPutAll: 'Cell -> map '.
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
	aStream nextPut: $.
]

{ #category : #'adding-removing' }
RMDCellColorMapRenderer >> removeAtIndex: anInteger ifAbsent: errorBlock [
	^ (anInteger between: 1 and: minAndColors size)
		ifTrue: [ minAndColors removeAt: anInteger ]
		ifFalse: [ errorBlock value ]
]
