Class {
	#name : #RMDAnimatDotRenderer,
	#superclass : #RMDAnimatRenderer,
	#instVars : [
		'diameter'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatDotRenderer class >> on: aString diameter: aNumber color: aColor [
	<script:
		'(RMDAnimatDotRenderer on: ''Goat'' diameter: 2 color: Color gray) inspect'>
	^ (self on: aString)
		diameter: aNumber;
		color: aColor;
		yourself
]

{ #category : #defaults }
RMDAnimatDotRenderer >> defaultDiameter [
	^ 3 @ 3
]

{ #category : #defaults }
RMDAnimatDotRenderer >> defaultRadius [
	^ 7
]

{ #category : #accessing }
RMDAnimatDotRenderer >> diameter [
	^ diameter ifNil: [ diameter := self defaultDiameter ]
]

{ #category : #accessing }
RMDAnimatDotRenderer >> diameter: aNumberOrPoint [
	diameter := aNumberOrPoint asPoint
]

{ #category : #drawing }
RMDAnimatDotRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [
	aCanvas
		fillOval: (Rectangle center: aPoint extent: self diameter)
		color: self color
		borderWidth: 1
		borderColor: Color black
]

{ #category : #accessing }
RMDAnimatDotRenderer >> name [
	^ 'dot renderer'
]

{ #category : #printing }
RMDAnimatDotRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	diameter printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' dot'
]
