Class {
	#name : #RMDAnimatDotRenderer,
	#superclass : #RMDAnimatRenderer,
	#instVars : [
		'color',
		'diameter'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDAnimatDotRenderer class >> on: aString diameter: aNumber color: aColor [
	^ (self on: aString)
		diameter: aNumber;
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDAnimatDotRenderer >> color [
	^ color ifNil: [ color := self defaultColor ]
]

{ #category : #accessing }
RMDAnimatDotRenderer >> color: aColor [
	color := aColor
]

{ #category : #defaults }
RMDAnimatDotRenderer >> defaultColor [
	^ Color yellow
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
