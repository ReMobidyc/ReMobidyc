Class {
	#name : #RMDAnimatTabularInspector,
	#superclass : #RMDTabularInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot',
		'#populationLabel'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDAnimatTabularInspector class >> defaultSpec [

	<spec>
	^ SpBoxLayout newVertical
		  add: #populationLabel height: self buttonHeight;
		  add: #table
]

{ #category : #accessing }
RMDAnimatTabularInspector >> animat [
	^ animat
]

{ #category : #accessing }
RMDAnimatTabularInspector >> animat: aString [
	animat := aString
]

{ #category : #initialization }
RMDAnimatTabularInspector >> initialize [
	super initialize.
	self property: #animat whenChangedDo: [ self updateTable ]
]

{ #category : #initialization }
RMDAnimatTabularInspector >> initializePresenters [

	super initializePresenters.
	populationLabel := self newLabel
		                   label: 'population: ';
		                   yourself
]

{ #category : #private }
RMDAnimatTabularInspector >> updateObservation [
	self updatePopulationLabel.
	super updateObservation .
]

{ #category : #private }
RMDAnimatTabularInspector >> updatePopulationLabel [

	populationLabel ifNotNil: [ 
		populationLabel label: 'Population: '
			, ((interpreter animatDefinitionAt: animat ifAbsent: [ nil ])
					 ifNotNil: [ :animatDef | 
						 (interpreter numberOfIndivisualsOf: animatDef) printString ]
					 ifNil: [ '?' ]) ]
]
