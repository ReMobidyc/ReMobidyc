Class {
	#name : #RMDAnimatTabularInspector,
	#superclass : #RMDTabularInspector,
	#traits : 'TRMDAnimatObservatory',
	#classTraits : 'TRMDAnimatObservatory classTrait',
	#instVars : [
		'#animat => ObservableSlot',
		'#populationLabel'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDAnimatTabularInspector class >> defaultLayout [

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

{ #category : #private }
RMDAnimatTabularInspector >> createTable [

	^ super createTable
		  contextMenu: [ self tableContextMenu ];
		  yourself
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

{ #category : #operations }
RMDAnimatTabularInspector >> openIndividualInspectorOn: anInteger [

	^ RMDIndividualTabularInspector new
		  interpreter: interpreter;
		  agent: anInteger;
		  open;
		  yourself
]

{ #category : #menu }
RMDAnimatTabularInspector >> tableContextMenu [

	^ self newMenu
		  addItem: [ :item | 
			  item
				  name: 'Open individual inspector';
				  icon: (Smalltalk ui iconNamed: 'history');
				  action: [ 
					  table selectedItem ifNotNil: [ :selectedItem | 
							  | column idString |
							  column := table columns
								            detect: [ :c | c title = 'ID' ]
								            ifNone: [ nil ].
							  idString := column
								              ifNotNil: [ 
									              column evaluation value: selectedItem ]
								              ifNil: [ '' ].
							  idString asInteger ifNotNil: [ :id | 
									  self openIndividualInspectorOn: id ] ] ] ];
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
		populationLabel label:
			'Population: ' , ((interpreter simulationModel
				  animatDefinitionAt: animat
				  ifAbsent: [ nil ])
				 ifNotNil: [ :animatDef | 
					 (interpreter numberOfIndividualsOf: animatDef) printString ]
				 ifNil: [ '?' ]) ]
]
