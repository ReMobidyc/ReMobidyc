Class {
	#name : #RMDRenderer,
	#superclass : #Object,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #drawing }
RMDRenderer >> draw: aRMDInterpreter on: aFormCanvas [
	^ self subclassResponsibility
]

{ #category : #private }
RMDRenderer >> pointFromX: modelX y: modelY interpreter: aRMDInterpreter on: aFormCanvas [
	| formExtent cellX cellY scale |
	formExtent := aFormCanvas form extent.
	cellX := aRMDInterpreter cellX: modelX.
	cellY := aRMDInterpreter cellY: modelY.
	scale := formExtent x asFloat
		/ aRMDInterpreter cellXDivisions asFloat
		min: formExtent y asFloat / aRMDInterpreter cellYDivisions asFloat.
	^ (cellX * scale)
		@ ((aRMDInterpreter cellYDivisions asFloat - cellY) * scale)
]
