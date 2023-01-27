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

{ #category : #enumerating }
RMDRenderer >> iconNamesDo: aBlock [
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
RMDRenderer >> isPatchRenderer [
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

	| patchX patchY |
	patchX := aRMDInterpreter patchX: modelX.
	patchY := aRMDInterpreter patchY: modelY.
	^ patchX * scale
	  @
		  (aRMDInterpreter simulationModel patchYDivisions asFloat - patchY
		   * scale)
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

{ #category : #rewriting }
RMDRenderer >> renameAnimat: aString to: anotherString [

	
]
