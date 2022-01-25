Class {
	#name : #RMDSimulationModel,
	#superclass : #Object,
	#instVars : [
		'simulationDefinition',
		'animatDefinitions',
		'cellDefinition',
		'worldDefinition',
		'actionDefinitions',
		'renderers',
		'taskDefinitions'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDSimulationModel class >> fromFile [

	<script: 'RMDSimulationModel fromFile open'>
	(UIManager default
		 chooseExistingFileReference: 'import simulation model'
		 extensions: #( 'rsm' )
		 path: ((FileLocator documents / 'ReMobidyc' / 'models')
				  ensureCreateDirectory / '*.rsm') absolutePath) ifNotNil: [ :ref | 
		^ self fromFileReference: ref ].
	^ nil
]

{ #category : #'instance creation' }
RMDSimulationModel class >> fromFileReference: aFileReference [

	| model |
	aFileReference readStreamDo: [ :stream | 
		model := RMDGrammar new simulationModel end parse: stream ].
	^ model isPetit2Failure
		  ifTrue: [ nil ]
		  ifFalse: [ model ]
]

{ #category : #'instance creation' }
RMDSimulationModel class >> goatAndWolf [

	^ self new
		  load: RMDWorldDefinitionNode empty;
		  load: RMDCellDefinitionNode grassField;
		  load: RMDAnimatDefinitionNode goat;
		  load: RMDAnimatDefinitionNode wolf;
		  load: RMDActionDefinitionNode reproduce;
		  load: RMDActionDefinitionNode prey_on;
		  load: (RMDTaskDefinitionNode goat_respire: '1000 [kcal/day]');
		  load: (RMDTaskDefinitionNode goat_starve: '1000 [kcal]');
		  load: RMDTaskDefinitionNode goat_walk_for_grass;
		  load:
			  (RMDTaskDefinitionNode
				   goat_eat: '3000 [kcal/day]'
				   upto: '10000[kcal]');
		  load: RMDTaskDefinitionNode goat_reproduce;
		  load: (RMDTaskDefinitionNode wolf_respire: '200 [kcal/day]');
		  load: (RMDTaskDefinitionNode wolf_starve: '500 [kcal]');
		  load: RMDTaskDefinitionNode wolf_chase_goat;
		  load:
			  (RMDTaskDefinitionNode wolf_prey_on_goat: '2000 [kcal]');
		  load: RMDTaskDefinitionNode wolf_reproduce;
		  load: (RMDTaskDefinitionNode
				   cell_grow_grass: '1500[kcal/day]'
				   upto: '1000000[kcal]');
		  load: (RMDSimulationDefinitionNode
				   timeDefinition:
					   (RMDSimulationTimeDefinitionNode
						    during: '2[year]'
						    by: '0.5[day]')
				   worldInitializer: RMDWorldInitializerNode empty
				   cellInitializer: (RMDCellInitializerNode
						    grassInitializer: 10
						    by: 10
						    of: '5[km]'
						    grass: '0[kcal]'
						    to: '700000[kcal]')
				   animatInitializers: { 
						   (RMDAnimatInitializerNode
							    goatInitializer: 100
							    bloodSugar: '5000[kcal]'
							    to: '9000[kcal]').
						   (RMDAnimatInitializerNode
							    wolfInitializer: 5
							    bloodSugar: '2000[kcal]'
							    to: '6000[kcal]') });
		  addRenderer: (RMDBackgroundColorRenderer color: Color black);
		  addRenderer: (RMDCellColorAlphaRenderer
				   color: Color green
				   alpha: 'here''s grass' asRMDExpression
				   between: '0[kcal]' asRMDExpression
				   and: '1000000[kcal]' asRMDExpression);
		  addRenderer:
			  (RMDAnimatDotRenderer on: 'Goat' diameter: 7 color: Color yellow);
		  addRenderer:
			  (RMDAnimatDotRenderer on: 'Wolf' diameter: 10 color: Color red);
		  yourself
]

{ #category : #'instance creation' }
RMDSimulationModel class >> sugarScape [
	^ self new
		load: RMDWorldDefinitionNode empty;
		load: RMDCellDefinitionNode grassField;
		load: RMDAnimatDefinitionNode goat;
		load: (RMDTaskDefinitionNode goat_respire: '2500 [kcal/day]');
		load: (RMDTaskDefinitionNode goat_starve: '1000 [kcal]');
		load: RMDTaskDefinitionNode goat_walk_for_grass;
		load:
			(RMDTaskDefinitionNode
				goat_eat: '3000 [kcal/day]'
				upto: '10000[kcal]');
		load: RMDActionDefinitionNode reproduce;
		load: (RMDTaskDefinitionNode goat_reproduce);
		load:
			(RMDTaskDefinitionNode
				cell_grow_grass: '1000[kcal/day]'
				upto: '1000000[kcal]');
		load:
			(RMDSimulationDefinitionNode
				timeDefinition: (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
				worldInitializer: RMDWorldInitializerNode empty
				cellInitializer:
					(RMDCellInitializerNode
						grassInitializer: 10
						by: 10
						of: '5[km]'
						grass: '0[kcal]'
						to: '700000[kcal]')
				animatInitializers:
					{(RMDAnimatInitializerNode
						goatInitializer: 100
						bloodSugar: '5000[kcal]'
						to: '9000[kcal]')});
		addRenderer: (RMDBackgroundColorRenderer color: Color black);
		addRenderer:
			(RMDCellColorAlphaRenderer
				color: Color green
				alpha: 'here''s grass' asRMDExpression
				between: '0[kcal]' asRMDExpression
				and: '1000000[kcal]' asRMDExpression);
		addRenderer: (RMDAnimatDotRenderer on: 'Goat' diameter: 7 color: Color yellow);
		yourself
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ actionDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> actionDefinitionAt: aString ifPresent: aBlock [
	^ actionDefinitions at: aString ifPresent: aBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> actionNames [
	^ actionDefinitions keys asSortedCollection
]

{ #category : #adding }
RMDSimulationModel >> addActionDefinition: aRMDActionDefinitionNode [

	actionDefinitions
		at: aRMDActionDefinitionNode identifier
		put: aRMDActionDefinitionNode.
	taskDefinitions do: [ :task | 
		task isTaskDefinitionNode ifTrue: [ 
			(task actionIdentifier isLocalActionIdentifierNode and: [ 
				 task actionIdentifier shortName
				 = aRMDActionDefinitionNode identifier ]) ifTrue: [ 
				task resetAction ] ] ].
	^ aRMDActionDefinitionNode
]

{ #category : #adding }
RMDSimulationModel >> addAnimatDefinition: aRMDAnimatDefinitionNode [
	^ animatDefinitions
		at: aRMDAnimatDefinitionNode identifier
		put: aRMDAnimatDefinitionNode
]

{ #category : #adding }
RMDSimulationModel >> addRenderer: aRMDRenderer [
	renderers add: aRMDRenderer
]

{ #category : #adding }
RMDSimulationModel >> addTaskDefinition: aRMDTaskDefinitionNode [
	^ taskDefinitions add: aRMDTaskDefinitionNode
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> animatDefinitionAt: aString ifAbsent: errorBlock [
	^ animatDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> animatDefinitionAt: aString ifPresent: aBlock [
	^ animatDefinitions at: aString ifPresent: aBlock
]

{ #category : #enumerating }
RMDSimulationModel >> animatDefinitionsDo: aBlock [
	animatDefinitions valuesDo: aBlock
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> animatInitializers [
	^ simulationDefinition animatInitializers
]

{ #category : #enumerating }
RMDSimulationModel >> animatInitializersDo: aBlock [
	simulationDefinition animatInitializers do: aBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> animatNames [
	^ animatDefinitions keys asSortedCollection
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellDefinition [
	^ cellDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> cellDefinition: aRMDCellDefinitionNode [
	cellDefinition := aRMDCellDefinitionNode
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> cellInitializer [
	^ simulationDefinition cellInitializer
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> cellLength [
	^ simulationDefinition cellInitializer length
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> cellXDivisions [
	^ simulationDefinition cellInitializer xDivisions
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> cellYDivisions [
	^ simulationDefinition cellInitializer yDivisions
]

{ #category : #'accessing - time' }
RMDSimulationModel >> deltaTime [
	^ simulationDefinition timeDefinition step numeric
]

{ #category : #'accessing - time' }
RMDSimulationModel >> duration [
	^ simulationDefinition timeDefinition duration numeric
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> east [
	^ self cellLength * self cellXDivisions
]

{ #category : #exporting }
RMDSimulationModel >> exportActions: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		actionDefinitions valuesDo: [ :actionDefinition | 
			actionDefinition printOn: stream ] ]
]

{ #category : #exporting }
RMDSimulationModel >> exportAgents: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		worldDefinition printOn: stream.
		stream nextPut: Character cr.
		cellDefinition printOn: stream.
		stream nextPut: Character cr.
		animatDefinitions valuesDo: [ :animatDefinition | 
			animatDefinition printOn: stream.
			stream nextPut: Character cr ] ]
]

{ #category : #exporting }
RMDSimulationModel >> exportModel [

	(UIManager default
		 chooseForSaveFileReference: 'export simulation model'
		 extensions: #( )
		 path: ((FileLocator documents / 'ReMobidyc' / 'models')
				  ensureCreateDirectory / '*') absolutePath) ifNotNil: [ :ref | 
		self exportModel: ref ]
]

{ #category : #exporting }
RMDSimulationModel >> exportModel: aFileReference [

	" #simulationDefinition . #animatDefinitions . #cellDefinition . #worldDefinition . #actionDefinitions . #renderers . #taskDefinitions "

	aFileReference
		ensureCreateDirectory;
		ensureDeleteAllChildren.
	self
		exportSimulationDefinition: aFileReference / 'simulation.rmd';
		exportAgents: aFileReference / 'agents.rmd';
		exportActions: aFileReference / 'actions.rmd';
		exportTaskDefinitions: aFileReference / 'tasks.rmd';
		exportVisualization: aFileReference / 'visualization.rmd'
]

{ #category : #exporting }
RMDSimulationModel >> exportSimulationDefinition: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		simulationDefinition printOn: stream ]
]

{ #category : #exporting }
RMDSimulationModel >> exportTaskDefinitions: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		taskDefinitions do: [ :taskDefinition | 
			taskDefinition printOn: stream.
			stream nextPut: Character cr ] ]
]

{ #category : #exporting }
RMDSimulationModel >> exportVisualization: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		renderers do: [ :renderer | 
			renderer printOn: stream.
			stream nextPut: Character cr ] ]
]

{ #category : #initialization }
RMDSimulationModel >> initialize [
	super initialize.
	simulationDefinition := RMDSimulationDefinitionNode empty.
	cellDefinition := RMDCellDefinitionNode empty.
	worldDefinition := RMDWorldDefinitionNode empty.
	animatDefinitions := Dictionary new.
	actionDefinitions := Dictionary new.
	taskDefinitions := OrderedCollection new.
	renderers := OrderedCollection new.
]

{ #category : #accessing }
RMDSimulationModel >> load: aRMDSyntaxNode [
	aRMDSyntaxNode isWorldDefinitionNode
		ifTrue: [ ^ self worldDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isCellDefinitionNode
		ifTrue: [ ^ self cellDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatDefinitionNode
		ifTrue: [ ^ self addAnimatDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isActionDefinitionNode
		ifTrue: [ ^ self addActionDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isTaskDefinitionNode
		ifTrue: [ ^ self addTaskDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isTerminalTaskDefinitionNode
		ifTrue: [ ^ self addTaskDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isSimulationDefinitionNode
		ifTrue: [ ^self simulationDefinition: aRMDSyntaxNode ].
	^ self error: 'Unknown load'
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> north [
	^ self cellLength * self cellYDivisions
]

{ #category : #'user interface' }
RMDSimulationModel >> open [

	^ (RMDSimulationModeler on: self)
		  openWithSpec;
		  yourself
]

{ #category : #adding }
RMDSimulationModel >> removeActionDefinition: aRMDActionDefinitionNode ifAbsent: errorBlock [

	actionDefinitions
		removeKey: aRMDActionDefinitionNode identifier
		ifAbsent: [ ^ errorBlock value ].
	taskDefinitions do: [ :task | 
		task isTaskDefinitionNode ifTrue: [ 
			(task actionIdentifier isLocalActionIdentifierNode and: [ 
				 task actionIdentifier shortName
				 = aRMDActionDefinitionNode identifier ]) ifTrue: [ 
				task resetAction ] ] ].
	^ aRMDActionDefinitionNode
]

{ #category : #adding }
RMDSimulationModel >> removeAnimat: aString ifAbsent: errorBlock [

	| animatDefinition |
	animatDefinition := animatDefinitions
		                    removeKey: aString
		                    ifAbsent: [ ^ errorBlock value ].
	taskDefinitions removeAllSuchThat: [ :taskDef | 
		taskDef subjectIdentifier = aString ].
	simulationDefinition animatInitializers:
		(simulationDefinition animatInitializers reject: [ :initializer | 
			 initializer animat = aString ]).
	simulationDefinition removeRenderersForAnimat: aString. 
	^ animatDefinition
]

{ #category : #adding }
RMDSimulationModel >> removeRenderer: aRMDRenderer ifAbsent: errorBlock [
	^ renderers remove: aRMDRenderer ifAbsent: errorBlock
]

{ #category : #adding }
RMDSimulationModel >> removeRenderersForAnimat: aString [

	renderers removeAllSuchThat: [ :renderer | 
		renderer isAnimatRendererFor: aString ]
]

{ #category : #adding }
RMDSimulationModel >> removeTaskDefinition: aRMDTaskDefinitionNode ifAbsent: errorBlock [
	^ taskDefinitions remove: aRMDTaskDefinitionNode ifAbsent: errorBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> renderers [
	^ renderers
]

{ #category : #enumerating }
RMDSimulationModel >> renderersDo: aBlock [
	renderers do: aBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> replaceTask: aRMDTaskDefinitionNode with: anotherRMDTaskDefinitionNode [
	| index |
	index := taskDefinitions indexOf: aRMDTaskDefinitionNode.
	index = 0
		ifTrue: [ taskDefinitions add: anotherRMDTaskDefinitionNode ]
		ifFalse:
			[ taskDefinitions at: index put: anotherRMDTaskDefinitionNode ].
	^ anotherRMDTaskDefinitionNode
]

{ #category : #accessing }
RMDSimulationModel >> repositoryName [
	^ 'model'
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition [
	^ simulationDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition: aRMDSimulationDefinition [
	simulationDefinition := aRMDSimulationDefinition
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> south [
	^ 0.0
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> taskDefinitions [
	^ Array withAll: taskDefinitions
]

{ #category : #enumerating }
RMDSimulationModel >> taskDefinitionsDo: aBlock [
	taskDefinitions do: aBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> taskNames [
	^ (taskDefinitions collect: #name) asSortedCollection
]

{ #category : #enumerating }
RMDSimulationModel >> tasksDo: aBlock [
	taskDefinitions do: aBlock
]

{ #category : #'type checking' }
RMDSimulationModel >> typecheck [
	self typechecker typecheck
]

{ #category : #'type checking' }
RMDSimulationModel >> typecheck: aRMDSyntaxNode [
	aRMDSyntaxNode typecheckIn: self typechecker
]

{ #category : #'type checking' }
RMDSimulationModel >> typechecker [
	^ RMDTypechecker new
		simulationModel: self;
		yourself
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> west [
	^ 0.0
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> worldDefinition [
	^ worldDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> worldDefinition: aRMDWorldDefinitionNode [
	worldDefinition := aRMDWorldDefinitionNode
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> worldInitializer [
	^ simulationDefinition worldInitializer
]
