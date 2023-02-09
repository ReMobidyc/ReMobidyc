Class {
	#name : #RMDAnimatPercentileInspector,
	#superclass : #RMDPercentileInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot',
		'#populationLabel'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #specs }
RMDAnimatPercentileInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #populationLabel height: self buttonHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #showsPercentiles;
				   add: #showsMin;
				   add: #showsMax;
				   add: #showsMean;
				   add: #showsSd)
		  height: self buttonHeight;
		  add: SpBoxLayout newVertical
]

{ #category : #accessing }
RMDAnimatPercentileInspector >> agentName [

	^ animat ifNil: [ 'Animat' ]
]

{ #category : #accessing }
RMDAnimatPercentileInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatPercentileInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatPercentileInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateImage ]
]

{ #category : #initialization }
RMDAnimatPercentileInspector >> initializePresenters [

	super initializePresenters.
	populationLabel := self newLabel
		                   label: 'population: ';
		                   yourself
]

{ #category : #accessing }
RMDAnimatPercentileInspector >> newLayout [

	^ SpBoxLayout newVertical
		  add: populationLabel height: self class buttonHeight;
		  add: (SpBoxLayout newHorizontal
				   add: showsPercentiles;
				   add: showsMin;
				   add: showsMax;
				   add: showsMean;
				   add: showsSd)
		  height: self class buttonHeight;
		  yourself
]

{ #category : #updating }
RMDAnimatPercentileInspector >> updateObservation [

	self updatePopulationLabel.
	super updateObservation
]

{ #category : #updating }
RMDAnimatPercentileInspector >> updatePopulationLabel [

	populationLabel ifNotNil: [ 
		populationLabel label:
			'Population: ' , ((interpreter simulationModel
				  animatDefinitionAt: animat
				  ifAbsent: [ nil ])
				 ifNotNil: [ :animatDef | 
					 (interpreter numberOfIndividualsOf: animatDef) printString ]
				 ifNil: [ '?' ]) ]
]
