Class {
	#name : #RMDPatchColorRangeRenderer,
	#superclass : #RMDPatchColorRenderer,
	#instVars : [
		'min',
		'max'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #comparing }
RMDPatchColorRangeRenderer >> = anObject [

	^ super = anObject and: [ 
		  min = anObject min and: [ max = anObject max ] ]
]

{ #category : #comparing }
RMDPatchColorRangeRenderer >> hash [

	^ (super hash bitXor: min hash) bitXor: max hash
]

{ #category : #initialization }
RMDPatchColorRangeRenderer >> initialize [
	super initialize.
	min := 0.0.
	max := 1.0
]

{ #category : #accessing }
RMDPatchColorRangeRenderer >> max [
	^ max
]

{ #category : #accessing }
RMDPatchColorRangeRenderer >> max: aRMDLiteral [
	max := aRMDLiteral
]

{ #category : #accessing }
RMDPatchColorRangeRenderer >> min [
	^ min
]

{ #category : #accessing }
RMDPatchColorRangeRenderer >> min: aRMDLiteral [
	min := aRMDLiteral
]

{ #category : #accessing }
RMDPatchColorRangeRenderer >> valueForIndividual: anInteger interpreter: aRMDInterpreter [

	| patchDef value |
	patchDef := aRMDInterpreter patchDefinition.
	aRMDInterpreter
		withObserverContextWithSubject: anInteger
		definition: patchDef
		do: [ value := expression evalIn: aRMDInterpreter ].
	^ value - min numeric / (max numeric - min numeric) min: 1.0 max: 0.0
]
