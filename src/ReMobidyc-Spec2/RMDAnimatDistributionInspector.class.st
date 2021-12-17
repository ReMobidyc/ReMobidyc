Class {
	#name : #RMDAnimatDistributionInspector,
	#superclass : #RMDDistributionInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot',
		'#populationLabel'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAnimatDistributionInspector class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #populationLabel height: self buttonHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #showsPercentiles;
				   add: #showsMin;
				   add: #showsMax;
				   add: #showsMean;
				   add: #showsSd)
		  height: self buttonHeight;
		  add: (SpScrollableLayout with: #image)
	"	expand: true
			fill: false
			padding: 0"
]

{ #category : #accessing }
RMDAnimatDistributionInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatDistributionInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatDistributionInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateImage ]
]

{ #category : #initialization }
RMDAnimatDistributionInspector >> initializePresenters [

	super initializePresenters.
	populationLabel := self newLabel
		                   label: 'population: ';
		                   yourself
]

{ #category : #private }
RMDAnimatDistributionInspector >> updateObservation [
	self updatePopulationLabel.
	super updateObservation .
]

{ #category : #private }
RMDAnimatDistributionInspector >> updatePopulationLabel [

	populationLabel ifNotNil: [ 
		populationLabel label: 'Population: '
			, ((interpreter animatDefinitionAt: animat ifAbsent: [ nil ])
					 ifNotNil: [ :animatDef | 
						 (interpreter numberOfIndivisualsOf: animatDef) printString ]
					 ifNil: [ '?' ]) ]
]
