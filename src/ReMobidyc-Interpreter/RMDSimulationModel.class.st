Class {
	#name : #RMDSimulationModel,
	#superclass : #Object,
	#instVars : [
		'simulationDefinition',
		'animatDefinitions',
		'worldDefinition',
		'actionDefinitions',
		'renderers',
		'taskDefinitions',
		'patchDefinition'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #accessing }
RMDSimulationModel class >> actionsFileName [

	^ 'actions.rmd'
]

{ #category : #accessing }
RMDSimulationModel class >> agentsFileName [

	^ 'agents.rmd'
]

{ #category : #'instance creation' }
RMDSimulationModel class >> goatAndWolf [

	^ self new
		  load: RMDWorldDefinitionNode empty;
		  load: RMDPatchDefinitionNode grassField;
		  load: RMDAnimatDefinitionNode goat;
		  load: RMDAnimatDefinitionNode wolf;
		  load: RMDBuiltinRepository current gain;
		  load: RMDBuiltinRepository current lose;
		  load: RMDBuiltinRepository current transfer;
		  load: RMDBuiltinRepository current move;
		  load: RMDBuiltinRepository current starve;
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
		  load: (RMDTaskDefinitionNode wolf_prey_on_goat: '2000 [kcal]');
		  load: RMDTaskDefinitionNode wolf_reproduce;
		  load: (RMDTaskDefinitionNode
				   patch_grow_grass: '1500[kcal/day]'
				   upto: '1000000[kcal]');
		  load: (RMDSimulationDefinitionNode
				   timeDefinition:
					   (RMDSimulationTimeDefinitionNode
						    during: '2[year]'
						    by: '0.5[day]')
				   worldInitializer: RMDWorldInitializerNode empty
				   patchInitializer: (RMDPatchInitializerNode
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
		  addRenderer: (RMDPatchColorAlphaRenderer
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

{ #category : #importing }
RMDSimulationModel class >> importModel [

	<script: 'RMDSimulationModel importModel open'>
	(UIManager default
		 chooseExistingFileReference: 'import simulation model'
		 extensions: #(  )
		 path: ((FileLocator documents / 'ReMobidyc' / 'models')
				  ensureCreateDirectory / '*') absolutePath) ifNotNil: [ :ref | 
		^ self importModel: ref ifError: [ nil ] ].
	^ nil
]

{ #category : #importing }
RMDSimulationModel class >> importModel: aFileReference ifError: errorBlock [

	[ 
	^ self new
		  importModel: aFileReference;
		  yourself ]
		on: FileException , RMDSyntaxError
		do: [ :ex | ^ errorBlock value ]
]

{ #category : #accessing }
RMDSimulationModel class >> simulationDefinitionFileName [

	^ 'simulation.rmd'
]

{ #category : #'instance creation' }
RMDSimulationModel class >> sugarScape [
	^ self new
		load: RMDWorldDefinitionNode empty;
		load: RMDPatchDefinitionNode grassField;
		load: RMDAnimatDefinitionNode goat;
		load: RMDBuiltinRepository current gain;
		load: RMDBuiltinRepository current lose;
		load: RMDBuiltinRepository current transfer;
		load: RMDBuiltinRepository current move;
		load: RMDBuiltinRepository current starve;
		load: RMDActionDefinitionNode reproduce;
		load: (RMDTaskDefinitionNode goat_respire: '2500 [kcal/day]');
		load: (RMDTaskDefinitionNode goat_starve: '1000 [kcal]');
		load: RMDTaskDefinitionNode goat_walk_for_grass;
		load:
			(RMDTaskDefinitionNode
				goat_eat: '3000 [kcal/day]'
				upto: '10000[kcal]');
		load: (RMDTaskDefinitionNode goat_reproduce);
		load:
			(RMDTaskDefinitionNode
				patch_grow_grass: '1000[kcal/day]'
				upto: '1000000[kcal]');
		load:
			(RMDSimulationDefinitionNode
				timeDefinition: (RMDSimulationTimeDefinitionNode during: '2[year]' by: '0.5[day]')
				worldInitializer: RMDWorldInitializerNode empty
				patchInitializer:
					(RMDPatchInitializerNode
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
			(RMDPatchColorAlphaRenderer
				color: Color green
				alpha: 'here''s grass' asRMDExpression
				between: '0[kcal]' asRMDExpression
				and: '1000000[kcal]' asRMDExpression);
		addRenderer: (RMDAnimatDotRenderer on: 'Goat' diameter: 7 color: Color yellow);
		yourself
]

{ #category : #accessing }
RMDSimulationModel class >> tasksFileName [

	^ 'tasks.rmd'
]

{ #category : #accessing }
RMDSimulationModel class >> visualizationFileName [

	^ 'visualization.rmd'
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> actionDefinitionAt: aString ifAbsent: errorBlock [
	^ actionDefinitions at: aString ifAbsent: errorBlock
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> actionDefinitionAt: aString ifPresent: aBlock [
	^ actionDefinitions at: aString ifPresent: aBlock
]

{ #category : #private }
RMDSimulationModel >> actionDefinitions [

	^ actionDefinitions
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
			task actionIdentifier = aRMDActionDefinitionNode identifier 
				ifTrue: [ task resetAction ] ] ].
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

{ #category : #private }
RMDSimulationModel >> animatDefinitions [
	^ animatDefinitions
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
	^ self patchLength * self patchXDivisions
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportActions: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		actionDefinitions valuesDo: [ :actionDefinition | 
			actionDefinition printOn: stream ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportAgents: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		worldDefinition printOn: stream.
		stream nextPut: Character cr.
		patchDefinition printOn: stream.
		stream nextPut: Character cr.
		animatDefinitions valuesDo: [ :animatDefinition | 
			animatDefinition printOn: stream.
			stream nextPut: Character cr ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportModel [

	(UIManager default
		 chooseDirectory: 'export simulation model'
		 path:
			 (FileLocator documents / 'ReMobidyc' / 'models')
				 ensureCreateDirectory absolutePath) ifNotNil: [ :ref | 
		self exportModel: ref ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportModel: aFileReference [

	aFileReference
		ensureCreateDirectory;
		ensureDeleteAllChildren.
	self
		exportSimulationDefinition:
			aFileReference / self class simulationDefinitionFileName;
		exportAgents: aFileReference / self class agentsFileName;
		exportActions: aFileReference / self class actionsFileName;
		exportTasks: aFileReference / self class tasksFileName;
		exportVisualization:
			aFileReference / self class visualizationFileName
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportSimulationDefinition: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		simulationDefinition printOn: stream ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportTasks: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		taskDefinitions do: [ :taskDefinition | 
			taskDefinition printOn: stream.
			stream nextPut: Character cr ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportVisualization: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		renderers do: [ :renderer | 
			renderer printOn: stream ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importActions: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar new actionDefinition end.
		[ stream atEnd ] whileFalse: [ 
			| source def |
			source := (String streamContents: [ :wstream | 
				           | line |
				           [ 
				           (line := stream nextLine) notNil and: [ 
					           line isEmpty or: [ line last ~= $. ] ] ] whileTrue: [ 
					           wstream
						           nextPutAll: line;
						           nextPut: Character cr ].
				           line ifNotNil: [ wstream nextPutAll: line ] ]) trim.
			source ifEmpty: [ ^ self ].
			def := parser parse: source.
			def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
			self load: def ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importAgents: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar new agentDefinition end.
		[ stream atEnd ] whileFalse: [ 
			| source def |
			source := (String streamContents: [ :wstream | 
				           | line |
				           [ 
				           (line := stream nextLine) notNil and: [ 
					           line isEmpty or: [ line last ~= $. ] ] ] whileTrue: [ 
					           wstream
						           nextPutAll: line;
						           nextPut: Character cr ].
				           line ifNotNil: [ wstream nextPutAll: line ] ]) trim.
			source ifEmpty: [ ^ self ].
			def := parser parse: source.
			def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
			self load: def ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importModel [

	(UIManager default
		 chooseExistingFileReference: 'import simulation model'
		 extensions: #(  )
		 path: ((FileLocator documents / 'ReMobidyc' / 'models')
				  ensureCreateDirectory / '*') absolutePath) ifNotNil: [ :ref | 
		[ self importModel: ref ]
			on: FileException , RMDSyntaxError
			do: [ :ex | ^ nil ].
		^ self ].
	^ nil
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importModel: aFileReference [
	self resetDefinitions.
	self
		importSimulationDefinition:
			aFileReference / self class simulationDefinitionFileName;
		importAgents: aFileReference / self class agentsFileName;
		importActions: aFileReference / self class actionsFileName;
		importTasks: aFileReference / self class tasksFileName;
		importVisualization:
			aFileReference / self class visualizationFileName
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importSimulationDefinition: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| def |
		def := RMDGrammar new simulationDefinition end parse:
			       stream contents.
		def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
		self load: def ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importTasks: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar new taskDefinition end.
		[ stream atEnd ] whileFalse: [ 
			| source def |
			source := (String streamContents: [ :wstream | 
				           | line |
				           [ 
				           (line := stream nextLine) notNil and: [ 
					           line isEmpty or: [ line last ~= $. ] ] ] whileTrue: [ 
					           wstream
						           nextPutAll: line;
						           nextPut: Character cr ].
				           line ifNotNil: [ wstream nextPutAll: line ] ]) trim.
			source ifEmpty: [ ^ self ].
			def := parser parse: source.
			def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
			self load: def ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importVisualization: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar new renderer end.
		[ stream atEnd ] whileFalse: [ 
			| source def |
			source := (String streamContents: [ :wstream | 
				           | line |
				           [ 
				           (line := stream nextLine) notNil and: [ 
					           line isEmpty or: [ line last ~= $. ] ] ] whileTrue: [ 
					           wstream
						           nextPutAll: line;
						           nextPut: Character cr ].
				           line ifNotNil: [ wstream nextPutAll: line ] ]) trim.
			source ifEmpty: [ ^ self ].
			def := parser parse: source.
			def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
			self addRenderer: def ] ]
]

{ #category : #initialization }
RMDSimulationModel >> initialize [

	super initialize.
	self resetDefinitions
]

{ #category : #accessing }
RMDSimulationModel >> load: aRMDSyntaxNode [
	aRMDSyntaxNode isWorldDefinitionNode
		ifTrue: [ ^ self worldDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isPatchDefinitionNode
		ifTrue: [ ^ self patchDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isAnimatDefinitionNode
		ifTrue: [ ^ self addAnimatDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isActionDefinitionNode
		ifTrue: [ ^ self addActionDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isTaskDefinitionNode
		ifTrue: [ ^ self addTaskDefinition: aRMDSyntaxNode ].
	aRMDSyntaxNode isSimulationDefinitionNode
		ifTrue: [ ^self simulationDefinition: aRMDSyntaxNode ].
	^ self error: 'Unknown load'
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> north [
	^ self patchLength * self patchYDivisions
]

{ #category : #'user interface' }
RMDSimulationModel >> open [

	^ (RMDSimulationModeler on: self)
		  openWithSpec;
		  yourself
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> patchDefinition [
	^ patchDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> patchDefinition: aRMDPatchDefinitionNode [
	patchDefinition := aRMDPatchDefinitionNode
]

{ #category : #'accessing - initializers' }
RMDSimulationModel >> patchInitializer [
	^ simulationDefinition patchInitializer
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> patchLength [
	^ simulationDefinition patchInitializer length
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> patchXDivisions [
	^ simulationDefinition patchInitializer xDivisions
]

{ #category : #'accessing - cells' }
RMDSimulationModel >> patchYDivisions [
	^ simulationDefinition patchInitializer yDivisions
]

{ #category : #adding }
RMDSimulationModel >> removeActionDefinition: aRMDActionDefinitionNode ifAbsent: errorBlock [

	actionDefinitions
		removeKey: aRMDActionDefinitionNode identifier
		ifAbsent: [ ^ errorBlock value ].
	taskDefinitions do: [ :task | 
		task isTaskDefinitionNode ifTrue: [ 
			task actionIdentifier = aRMDActionDefinitionNode identifier 
				ifTrue: [ task resetAction ] ] ].
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
	self removeRenderersForAnimat: aString.
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

{ #category : #initialization }
RMDSimulationModel >> resetDefinitions [

	simulationDefinition := RMDSimulationDefinitionNode empty.
	patchDefinition := RMDPatchDefinitionNode empty.
	worldDefinition := RMDWorldDefinitionNode empty.
	animatDefinitions := Dictionary new.
	actionDefinitions := Dictionary new.
	taskDefinitions := OrderedCollection new.
	renderers := OrderedCollection new
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
