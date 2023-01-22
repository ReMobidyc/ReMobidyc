Class {
	#name : #RMDPopulationInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => ObservableSlot',
		'#populationTable',
		'#currentPopulation',
		'#maxPopulation',
		'#minPopulation',
		'#lastUpdateTime'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDPopulationInspector class >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: #populationTable;
		  yourself
]

{ #category : #'instance creation' }
RMDPopulationInspector class >> on: aRMDInterpreter [

	^ self new
		  interpreter: aRMDInterpreter;
		  yourself
]

{ #category : #initialization }
RMDPopulationInspector >> initialize [

	super initialize.
	currentPopulation := Dictionary new.
	maxPopulation := Dictionary new.
	minPopulation := Dictionary new
]

{ #category : #initialization }
RMDPopulationInspector >> initializePresenters [

	super initializePresenters.
	populationTable := self newTable
		                   disable;
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'name'
				                    evaluated: #yourself);
		                   addColumn: (SpStringTableColumn
				                    title: 'min'
				                    evaluated: [ :name | 
					                    self printNat:
							                    (minPopulation at: name ifAbsent: [ nil ]) ]);
		                   addColumn: (SpStringTableColumn
				                    title: 'max'
				                    evaluated: [ :name | 
					                    self printNat:
							                    (maxPopulation at: name ifAbsent: [ nil ]) ]);
		                   addColumn:
			                   (SpStringTableColumn
				                    title: 'now'
				                    evaluated: [ :name | 
					                    self printNat:
							                    (currentPopulation
								                     at: name
								                     ifAbsent: [ nil ]) ]);
		                   yourself
]

{ #category : #accessing }
RMDPopulationInspector >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	self updateTableItems.
	interpreter announcer weak
		when: RMDTimeChanged
		send: #updateObservation
		to: self
]

{ #category : #printing }
RMDPopulationInspector >> printNat: anInteger [

	^ anInteger
		  ifNotNil: [ 
			  anInteger > 0
				  ifTrue: [ 
					  | nat |
					  nat := anInteger.
					  ',' join: (Array streamContents: [ :stream | 
							   [ nat > 0 ] whileTrue: [ 
								   stream nextPut: nat % 1000.
								   nat := nat // 1000 ] ]) reversed ]
				  ifFalse: [ '0' ] ]
		  ifNil: [ '-' ]
]

{ #category : #accessing }
RMDPopulationInspector >> stagePrefix [
	^ '  '
]

{ #category : #updating }
RMDPopulationInspector >> updateObservation [

	interpreter ifNotNil: [ 
		| model speciesPopulations now |
		model := interpreter simulationModel.
		speciesPopulations := Dictionary new.
		model animatDefinitionsDo: [ :animat | 
			| population stage |
			population := interpreter numberOfIndivisualsOf: animat.
			speciesPopulations
				at: animat species
				put:
				(speciesPopulations at: animat species ifAbsent: [ 0 ])
				+ population.
			stage := self stagePrefix , animat name.
			currentPopulation at: stage put: population.
			minPopulation
				at: stage
				put: ((minPopulation at: stage ifAbsent: [ Float infinity ]) min:
						 population).
			maxPopulation
				at: stage
				put: ((maxPopulation at: stage ifAbsent: [ 0 ]) max: population) ].
		speciesPopulations keysAndValuesDo: [ :species :population | 
			currentPopulation at: species put: population.
			minPopulation
				at: species
				put:
					((minPopulation at: species ifAbsent: [ Float infinity ]) min:
						 population).
			maxPopulation
				at: species
				put: ((maxPopulation at: species ifAbsent: [ 0 ]) max: population) ].
		now := DateAndTime now.
		(lastUpdateTime isNil or: [ now - lastUpdateTime > 100 milliSecond ]) 
			ifTrue: [ 
				lastUpdateTime := now.
				populationTable ifNotNil: #refresh ] ]
]

{ #category : #updating }
RMDPopulationInspector >> updateTableItems [

	interpreter ifNotNil: [ 
		| model |
		model := interpreter simulationModel.
		populationTable items: (Array streamContents: [ :stream | 
				 model speciesNames do: [ :species | 
					 stream nextPut: species.
					 model animatDefinitionsDo: [ :animat | 
						 animat species = species ifTrue: [ 
							 stream nextPut: self stagePrefix , animat name ] ] ] ]) ]
]
