Class {
	#name : #RMDCellColorRangeRenderer,
	#superclass : #RMDCellColorRenderer,
	#instVars : [
		'min',
		'max'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #initialization }
RMDCellColorRangeRenderer >> initialize [
	super initialize.
	min := 0.0.
	max := 1.0
]

{ #category : #accessing }
RMDCellColorRangeRenderer >> max [
	^ max
]

{ #category : #accessing }
RMDCellColorRangeRenderer >> max: aRMDLiteral [
	max := aRMDLiteral
]

{ #category : #accessing }
RMDCellColorRangeRenderer >> min [
	^ min
]

{ #category : #accessing }
RMDCellColorRangeRenderer >> min: aRMDLiteral [
	min := aRMDLiteral
]

{ #category : #accessing }
RMDCellColorRangeRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [
	| cellDef value |
	cellDef := aRMDInterpreter cellDefinition.
	aRMDInterpreter
		setObserverContextWithSubject: anInteger
		species: cellDef.
	value := expression evalIn: aRMDInterpreter.
	^ (value - min numeric) / (max numeric - min numeric)
		min: 1.0
		max: 0.0
]
