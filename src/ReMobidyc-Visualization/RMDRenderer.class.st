Class {
	#name : #RMDRenderer,
	#superclass : #Object,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #comparing }
RMDRenderer >> = anObject [
	^ self class = anObject class and: [ color = anObject color ]
]

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

{ #category : #comparing }
RMDRenderer >> hash [

	^ self class hash bitXor: color hash
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

{ #category : #testing }
RMDRenderer >> isCellRenderer [
	^ false
]

{ #category : #testing }
RMDRenderer >> isWorldRenderer [
	^ false
]

{ #category : #accessing }
RMDRenderer >> name [
	^ self subclassResponsibility 
]

{ #category : #private }
RMDRenderer >> pointFromX: modelX y: modelY interpreter: aRMDInterpreter scale: scale [
	| cellX cellY |
	cellX := aRMDInterpreter cellX: modelX.
	cellY := aRMDInterpreter cellY: modelY.
	^ (cellX * scale)
		@ ((aRMDInterpreter cellYDivisions asFloat - cellY) * scale)
]

{ #category : #printing }
RMDRenderer >> printColor: c on: aStream [

	| colorName |
	colorName := c name.
	(Color registeredColorNames includes: colorName)
		ifTrue: [ aStream nextPutAll: colorName ]
		ifFalse: [ 
			aStream
				nextPut: $#;
				nextPutAll: c asHexString ]
]

{ #category : #printing }
RMDRenderer >> printColorOn: aStream [

	self printColor: color on: aStream
]
