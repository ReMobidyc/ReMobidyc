Class {
	#name : #RMDCellColorRangeRenderer,
	#superclass : #RMDCellColorRenderer,
	#instVars : [
		'min',
		'max'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #comparing }
RMDCellColorRangeRenderer >> = anObject [

	^ super = anObject and: [ 
		  min = anObject min and: [ max = anObject max ] ]
]

{ #category : #comparing }
RMDCellColorRangeRenderer >> hash [

	^ (super hash bitXor: min hash) bitXor: max hash
]

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
		withObserverContextWithSubject: anInteger
		species: cellDef
		do: [ value := expression evalIn: aRMDInterpreter ].
	^ (value - min numeric) / (max numeric - min numeric)
		min: 1.0
		max: 0.0
]
