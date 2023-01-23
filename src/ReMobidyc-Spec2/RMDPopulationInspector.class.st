Class {
	#name : #RMDPopulationInspector,
	#superclass : #RMDPresenter,
	#instVars : [
		'#interpreter => ObservableSlot',
		'#populationTable',
		'#populationChart',
		'#currentPopulation',
		'#maxPopulation',
		'#minPopulation',
		'#lastUpdateTime',
		'#populationByTime'
	],
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #layout }
RMDPopulationInspector class >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  add: #populationTable;
		  add: #populationChart width: 400;
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
	minPopulation := Dictionary new.
	populationByTime := OrderedCollection new: 1024
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
		                   whenSelectionChangedDo: [ 
			                   self updatePopulationChart ];
		                   yourself.
	populationChart := self newImage
		                   autoScale: false;
		                   image: (Form extent: 400 @ 300 depth: 32);
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
		populationByTime add: currentPopulation copy.
		now := DateAndTime now.
		(lastUpdateTime isNil or: [ now - lastUpdateTime > 100 milliSecond ]) 
			ifTrue: [ 
				lastUpdateTime := now.
				populationTable ifNotNil: #refresh.
				self updatePopulationChart ] ]
]

{ #category : #updating }
RMDPopulationInspector >> updatePopulationChart [

	| form canvas |
	form := populationChart image.
	canvas := form getCanvas.
	canvas fillColor: Color white.
	populationByTime ifEmpty: [ ^ self ].
	populationTable selectedItem ifNotNil: [ :animat | 
		| chartWidth chartHeight font fontHeight min max |
		font := TextStyle defaultFont.
		fontHeight := font height.
		chartWidth := form width.
		chartHeight := form height - (fontHeight * 2).
		min := minPopulation at: animat ifAbsent: [ ^ self ].
		max := maxPopulation at: animat ifAbsent: [ ^ self ].
		min < max ifTrue: [ 
			| xScale yScale minString maxString |
			xScale := chartWidth
			          /
				          (interpreter simulationDefinition timeDefinition
					           duration numeric
				           /
				           interpreter simulationDefinition timeDefinition step
					           numeric) ceiling.
			yScale := chartHeight / (max - min).
			minString := 'min = ' , min printString.
			maxString := 'max = ' , max printString.
			canvas
				drawString: minString
				at: 0 @ (chartHeight - fontHeight)
				font: font
				color: Color gray.
			canvas
				drawString: maxString
				at: 0 @ 0
				font: font
				color: Color gray.
			canvas
				line: interpreter time * xScale @ 0
				to: interpreter time * xScale @ chartHeight
				width: 1
				color: Color red.
			1 to: populationByTime size - 1 do: [ :time1 | 
				| time2 value1 value2 |
				time2 := time1 + 1.
				value1 := (populationByTime at: time1) at: animat.
				value2 := (populationByTime at: time2) at: animat.
				canvas
					line: (time1 * xScale) rounded
						@ (chartHeight - (value1 - min * yScale) rounded)
					to: (time2 * xScale) rounded
						@ (chartHeight - (value2 - min * yScale) rounded)
					width: 1
					color: Color black ] ].
		canvas
			drawString: '0'
			at: 0 @ chartHeight
			font: font
			color: Color gray.
		populationByTime size > 1 ifTrue: [ 
			| time timeUnit timeString |
			time := populationByTime size - 1
			        *
			        interpreter simulationDefinition timeDefinition step
				        numeric.
			timeUnit := interpreter simulationDefinition timeDefinition
				            duration unit.
			timeString := ((timeUnit fromSI: time) printShowingDecimalPlaces: 1)
			              , ' [' , timeUnit printString , ']'.
			canvas
				drawString: timeString
				at: chartWidth - (font widthOfString: timeString) @ chartHeight
				font: font
				color: Color gray ].
		populationChart image: form.
		^ form ]
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
