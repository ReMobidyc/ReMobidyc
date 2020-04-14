Class {
	#name : #RMDRenderer,
	#superclass : #Object,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #drawing }
RMDRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
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
