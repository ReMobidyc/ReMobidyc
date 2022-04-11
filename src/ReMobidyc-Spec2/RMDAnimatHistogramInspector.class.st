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

{ #category : #layout }
RMDAnimatHistogramInspector class >> defaultLayout [

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

{ #category : #accessing }
RMDAnimatHistogramInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: populationLabel height: self class buttonHeight;
		  yourself
]

{ #category : #accessing }
RMDAnimatHistogramInspector >> speciesName [

	^ animat ifNil: [ 'Animat' ]
]

{ #category : #updating }
RMDAnimatHistogramInspector >> updateObservation [

	self updatePopulationLabel.
	super updateObservation
]

{ #category : #updating }
RMDAnimatHistogramInspector >> updatePopulationLabel [

	populationLabel ifNotNil: [ 
		populationLabel label: 'Population: '
			, ((interpreter animatDefinitionAt: animat ifAbsent: [ nil ])
					 ifNotNil: [ :animatDef | 
						 (interpreter numberOfIndivisualsOf: animatDef) printString ]
					 ifNil: [ '?' ]) ]
]
