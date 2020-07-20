Class {
	#name : #RMDRenderer,
	#superclass : #Object,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #accessing }
RMDRenderer >> color [
	^ color ifNil: [ color := self defaultColor ]
]

{ #category : #accessing }
RMDRenderer >> color: aColor [
	color := aColor
]

{ #category : #defaults }
RMDRenderer >> defaultColor [
	^ Color yellow
]

{ #category : #drawing }
RMDRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	^ self subclassResponsibility
]

{ #category : #initialization }
RMDRenderer >> initialize [
	super initialize.
	color := self defaultColor
]

{ #category : #testing }
RMDRenderer >> isAnimatRendererFor: aString [
	^ false
]

{ #category : #private }
RMDRenderer >> pointFromX: modelX y: modelY interpreter: aRMDInterpreter scale: scale [
	| cellX cellY |
	cellX := aRMDInterpreter cellX: modelX.
	cellY := aRMDInterpreter cellY: modelY.
	^ (cellX * scale)
		@ ((aRMDInterpreter cellYDivisions asFloat - cellY) * scale)
]
