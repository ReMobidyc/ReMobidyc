Class {
	#name : #RMDAnimatHistogramInspector,
	#superclass : #RMDHistogramInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot',
		'#populationLabel'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #specs }
RMDAnimatHistogramInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #populationLabel height: self buttonHeight;
		  yourself
]

{ #category : #accessing }
RMDAnimatHistogramInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatHistogramInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatHistogramInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateImage ]
]

{ #category : #initialization }
RMDAnimatHistogramInspector >> initializePresenters [

	super initializePresenters.
	populationLabel := self newLabel
		                   label: 'population: ';
		                   yourself
]

{ #category : #'instance creation' }
RMDAnimatHistogramInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: populationLabel height: self class buttonHeight;
		  yourself
]

{ #category : #private }
RMDAnimatHistogramInspector >> updateObservation [

	self updatePopulationLabel.
	super updateObservation
]

{ #category : #private }
RMDAnimatHistogramInspector >> updatePopulationLabel [

	populationLabel ifNotNil: [ 
		populationLabel label: 'Population: '
			, ((interpreter animatDefinitionAt: animat ifAbsent: [ nil ])
					 ifNotNil: [ :animatDef | 
						 (interpreter numberOfIndivisualsOf: animatDef) printString ]
					 ifNil: [ '?' ]) ]
]
