Class {
	#name : #RMDSimulationModel,
	#superclass : #Object,
	#instVars : [
		'metadata',
		'simulationDefinition',
		'animatDefinitions',
		'worldDefinition',
		'actionDefinitions',
		'renderers',
		'taskDefinitions',
		'patchDefinition',
		'icons',
		'variability'
	],
	#category : #'ReMobidyc-Interpreter-Core'
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

	| model |
	model := self new
		         name: 'Goat and Wolf';
		         authors: { 'Tomohiro Oda' };
		         date: '2023-01-07T10:11:44.444037+09:00' asDateAndTime;
		         description:
			         'A simple demo that wolves chase and eat goats in a grass field.';
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
		         load:
			         (RMDTaskDefinitionNode goat_respire: '1000 [kcal/day]');
		         load: (RMDTaskDefinitionNode goat_starve: '1000 [kcal]');
		         load: RMDTaskDefinitionNode goat_walk_for_grass;
		         load:
			         (RMDTaskDefinitionNode
				          goat_eat: '3000 [kcal/day]'
				          upto: '10000[kcal]');
		         load: RMDTaskDefinitionNode goat_reproduce;
		         load:
			         (RMDTaskDefinitionNode wolf_respire: '200 [kcal/day]');
		         load: (RMDTaskDefinitionNode wolf_starve: '500 [kcal]');
		         load: RMDTaskDefinitionNode wolf_chase_goat;
		         load:
			         (RMDTaskDefinitionNode wolf_prey_on_goat: '2000 [kcal]');
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
		         addRenderer:
			         (RMDBackgroundColorRenderer color: Color black);
		         addRenderer: (RMDPatchColorAlphaRenderer
				          color: Color green
				          alpha: 'my grass' asRMDExpression
				          between: '0[kcal]' asRMDExpression
				          and: '1000000[kcal]' asRMDExpression);
		         addRenderer:
			         (RMDAnimatDotRenderer
				          on: 'Goat'
				          shapeSize: 7
				          color: Color yellow);
		         addRenderer:
			         (RMDAnimatDotRenderer
				          on: 'Wolf'
				          shapeSize: 10
				          color: Color red);
		         yourself.
	model variability multiplicity: 10.
	^ model
]

{ #category : #accessing }
RMDSimulationModel class >> iconsDirectoryName [

	^ 'icons'
]

{ #category : #importing }
RMDSimulationModel class >> importMetadata: aFileReference ifError: errorBlock [

	^ [ 
	  aFileReference / self metadataFileName readStreamDo: [ :stream | 
		  RMDMetadata fromJsonString: stream contents ] ]
		  on: FileException
		  do: [ :ex | errorBlock value ]
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
RMDSimulationModel class >> metadataFileName [

	^ 'metadata.json'
]

{ #category : #accessing }
RMDSimulationModel class >> simulationDefinitionFileName [

	^ 'simulation.rmd'
]

{ #category : #'instance creation' }
RMDSimulationModel class >> sugarScape [

	^ self new
		  name: 'Sugarscape';
		  authors: {'Tomohiro Oda'};
		  date: '2023-01-07T10:11:44.444037+09:00' asDateAndTime;
		  description:
			  'A simple demo that goat moves around to eat grasses on the field.';
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
		  load: RMDTaskDefinitionNode goat_reproduce;
		  load: (RMDTaskDefinitionNode
				   patch_grow_grass: '1000[kcal/day]'
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
				   animatInitializers: { (RMDAnimatInitializerNode
						    goatInitializer: 100
						    bloodSugar: '5000[kcal]'
						    to: '9000[kcal]') });
		  addRenderer: (RMDBackgroundColorRenderer color: Color black);
		  addRenderer: (RMDPatchColorAlphaRenderer
				   color: Color green
				   alpha: 'my grass' asRMDExpression
				   between: '0[kcal]' asRMDExpression
				   and: '1000000[kcal]' asRMDExpression);
		  addRenderer:
			  (RMDAnimatDotRenderer on: 'Goat' shapeSize: 7 color: Color yellow);
		  yourself
]

{ #category : #accessing }
RMDSimulationModel class >> tasksFileName [

	^ 'tasks.rmd'
]

{ #category : #accessing }
RMDSimulationModel class >> variabilityFileName [

	^ 'variability.rmd'
]

{ #category : #accessing }
RMDSimulationModel class >> visualizationFileName [

	^ 'visualization.rmd'
]

{ #category : #accessing }
RMDSimulationModel class >> worldDataSourceFileName [

	^ 'world.csv'
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

{ #category : #enumerating }
RMDSimulationModel >> actionDefinitionsDo: aBlock [

	self actionDefinitions do: aBlock
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
RMDSimulationModel >> agentDefinitionAt: aString ifAbsent: errorBlock [

	aString = 'World' ifTrue: [ ^ self worldDefinition ].
	aString = 'Patch' ifTrue: [ ^ self patchDefinition ].
	^ self animatDefinitionAt: aString ifAbsent: errorBlock
]

{ #category : #enumerating }
RMDSimulationModel >> agentDefinitionsDo: aBlock [

	worldDefinition ifNotNil: aBlock.
	patchDefinition ifNotNil: aBlock.
	self animatDefinitionsDo: aBlock
]

{ #category : #enumerating }
RMDSimulationModel >> agentInitializersDo: aBlock [

	self worldInitializer ifNotNil: aBlock.
	self patchInitializer ifNotNil: aBlock.
	self animatInitializersDo: aBlock
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

	^ animatDefinitions keys asArray
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> authors [

	^ metadata authors
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> authors: anArrayOfString [

	metadata authors: anArrayOfString
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> copyAnimat: aString to: anotherString [

	| animatDef |
	animatDef := self animatDefinitionAt: aString ifAbsent: [ ^ self ].
	(animatDefinitions includesKey: anotherString) ifTrue: [ ^ self ].
	animatDef := animatDef copy.
	animatDef renameAnimat: aString to: anotherString.
	self addAnimatDefinition: animatDef.
	taskDefinitions do: [ :taskDef | 
		taskDef subjectIdentifier = aString ifTrue: [ 
			self addTaskDefinition: (taskDef copy
					 subjectIdentifier: anotherString;
					 yourself) ] ].
	renderers do: [ :renderer | 
		(renderer isAnimatRendererFor: aString) ifTrue: [ 
			self addRenderer:
				(renderer copy renameAnimat: aString to: anotherString) ] ]
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> date [
	^ metadata date
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> date: aDateString [

	metadata description: aDateString
]

{ #category : #'accessing - time' }
RMDSimulationModel >> deltaTime [
	^ simulationDefinition timeDefinition step numeric
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> description [

	^ metadata description
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> description: aString [

	metadata description: aString
]

{ #category : #'accessing - time' }
RMDSimulationModel >> duration [
	^ simulationDefinition timeDefinition duration numeric
]

{ #category : #'accessing - time' }
RMDSimulationModel >> durationUnit [

	^ simulationDefinition timeDefinition duration unit
]

{ #category : #'accessing - patch' }
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
RMDSimulationModel >> exportDataSource: aFileReference [

	self worldDefinition dataSource ifNotNil: [ :dataSource |
		dataSource writeToCsv: aFileReference / 'World.csv' ].
	self patchDefinition dataSource ifNotNil: [ :dataSource |
		dataSource writeToCsv: aFileReference / 'Patch.csv' ].
	self animatDefinitionsDo: [ :animatDefinition |
		animatDefinition dataSource ifNotNil: [ :dataSource |
			dataSource writeToCsv:
				(aFileReference / animatDefinition identifier withExtension: 'csv') ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportIcons: aFileReference [

	self removeUnusedIcons.
	icons keysAndValuesDo: [ :name :form | 
		PNGReadWriter
			putForm: form
			onFileNamed: (aFileReference / name) ensureDelete ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportMetadata: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		metadata printJsonOn: stream ]
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
		exportMetadata: aFileReference / self class metadataFileName;
		exportVariability: aFileReference / self class variabilityFileName;
		exportSimulationDefinition:
			aFileReference / self class simulationDefinitionFileName;
		exportAgents: aFileReference / self class agentsFileName;
		exportDataSource: aFileReference;
		exportActions: aFileReference / self class actionsFileName;
		exportTasks: aFileReference / self class tasksFileName;
		exportIcons:
			(aFileReference / self class iconsDirectoryName)
				ensureCreateDirectory;
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
RMDSimulationModel >> exportVariability: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		variability printOn: stream ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> exportVisualization: aFileReference [

	aFileReference lfWriteStreamDo: [ :stream | 
		renderers do: [ :renderer | 
			renderer printOn: stream ] ]
]

{ #category : #'accessing - icons' }
RMDSimulationModel >> iconAt: aString ifAbsent: errorBlock [

	^ icons at: aString ifAbsent: errorBlock
]

{ #category : #'accessing - icons' }
RMDSimulationModel >> iconAt: aString put: aForm [

	^ icons at: aString put: aForm
]

{ #category : #'accessing - icons' }
RMDSimulationModel >> iconNames [

	^ icons keys asSortedCollection
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importActions: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar current actionDefinition end.
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
		parser := RMDGrammar current agentDefinition end.
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
RMDSimulationModel >> importDataSource: aFileReference [

	aFileReference / 'World.csv'
		ifExists: [ :ref |
			self worldDefinition dataSource: (RMDDataSource readFromCsv: ref) ]
		ifAbsent: [ nil ].
	aFileReference / 'Patch.csv'
		ifExists: [ :ref |
			self patchDefinition dataSource: (RMDDataSource readFromCsv: ref) ]
		ifAbsent: [ nil ].
	self animatDefinitionsDo: [ :animatDefinition |
		(aFileReference / animatDefinition identifier withExtension: 'csv')
			ifExists: [ :ref |
				animatDefinition dataSource: (RMDDataSource readFromCsv: ref) ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importIcons: aFileReference [

	aFileReference isDirectory ifFalse: [ ^ self ].
	(aFileReference filesMatching: '*.png') do: [ :pngRef | 
		(PNGReadWriter formFromFileNamed: pngRef) ifNotNil: [ :form | 
			self iconAt: pngRef basename put: form ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importMetadata: aFileReference [

	aFileReference exists
		ifTrue: [ 
			aFileReference readStreamDo: [ :stream | 
				metadata readFromJsonString: stream contents ] ]
		ifFalse: [ 
			metadata
				name: aFileReference parent basename;
				authors: metadata defaultAuthors;
				description: metadata defaultDescription;
				date: DateAndTime now ]
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
		importMetadata: aFileReference / self class metadataFileName;
		importVariability: aFileReference / self class variabilityFileName;
		importSimulationDefinition:
			aFileReference / self class simulationDefinitionFileName;
		importAgents: aFileReference / self class agentsFileName;
		importDataSource: aFileReference;
		importActions: aFileReference / self class actionsFileName;
		importTasks: aFileReference / self class tasksFileName;
		importIcons: aFileReference / self class iconsDirectoryName;
		importVisualization:
			aFileReference / self class visualizationFileName
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importSimulationDefinition: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| def |
		def := RMDGrammar current simulationDefinition end parse:
			       stream contents.
		def isPetit2Failure ifTrue: [ ^ RMDSyntaxError signal: def ].
		self load: def ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importTasks: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar current taskDefinition end.
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
RMDSimulationModel >> importVariability: aFileReference [

	aFileReference isFile ifTrue: [ 
		aFileReference readStreamDo: [ :stream | 
			| node |
			node := RMDGrammar current variability end parse: stream contents.
			node isPetit2Success ifTrue: [ self variability: node ] ] ]
]

{ #category : #'exporting/importing' }
RMDSimulationModel >> importVisualization: aFileReference [

	aFileReference readStreamDo: [ :stream | 
		| parser |
		parser := RMDGrammar current renderer end.
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

{ #category : #'accessing - initializers' }
RMDSimulationModel >> initializersFor: aString do: aBlock [

	aString = 'World' ifTrue: [
		aBlock cull: self worldInitializer.
		^ self ].
	aString = 'Patch' ifTrue: [
		aBlock cull: self patchInitializer.
		^ self ].
	self animatInitializers do: [ :initializer |
		initializer agentName = aString ifTrue: [ aBlock cull: initializer ] ]
]

{ #category : #'accessing - meta parameters' }
RMDSimulationModel >> instantiateWithMetaParameters: aDictionary [

	^ self shallowCopy
		  metaparameters: aDictionary;
		  yourself
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterForDryRun [

	^ self interpreterOn: RMDDryMemory new
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterOn: aRMDMemory [

	^ RMDInterpreter new
		  setMemory: aRMDMemory;
		  setContext: RMDActionContext new;
		  simulationModel: self;
		  yourself
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterOnExistingFile: basePath modelPath: modelPath [

	^ self interpreterOn:
		  (RMDFileMemory on: basePath modelPath: modelPath)
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterOnFile [

	| memory |
	memory := RMDFileMemory for: self.
	self exportModel: memory modelPath.
	^ self interpreterOn: memory
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterOnFile: basePath modelPath: modelPath [

	^ self interpreterOn:
		  (RMDFileMemory on: basePath modelPath: modelPath)
]

{ #category : #interpreting }
RMDSimulationModel >> interpreterOnMemory [

	^ self interpreterOn: RMDOnMemory new
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

{ #category : #interpreting }
RMDSimulationModel >> metaInterpreterForDryRun [

	^ RMDMetaInterpreter forDryRunOn: self
]

{ #category : #interpreting }
RMDSimulationModel >> metaInterpreterOnFile [

	^ RMDMetaInterpreter
		  on: self
		  modelPath: (RMDFileMemory modelPathFor: self)
]

{ #category : #interpreting }
RMDSimulationModel >> metaInterpreterOnModelPath: aFileReference [

	^ RMDMetaInterpreter on: self modelPath: aFileReference
]

{ #category : #interpreting }
RMDSimulationModel >> metaInterpreterOnReadOnlyModelPath: aFileReference [

	^ RMDMetaInterpreter on: self readOnlyModelPath: aFileReference
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> metadata [

	^ metadata
]

{ #category : #'accessing - meta parameters' }
RMDSimulationModel >> metaparameters: aDictionary [

	variability := variability copy.
	simulationDefinition := simulationDefinition metaparameters:
		                        aDictionary.
	animatDefinitions := (animatDefinitions associations collect: [ 
		                      :assoc | 
		                      assoc key
		                      -> (assoc value metaparameters: aDictionary) ])
		                     asOrderedDictionary.
	worldDefinition := worldDefinition metaparameters: aDictionary.
	actionDefinitions := (actionDefinitions associations collect: [ 
		                      :assoc | 
		                      assoc key
		                      -> (assoc value metaparameters: aDictionary) ])
		                     asOrderedDictionary.
	renderers := renderers collect: #copy.
	taskDefinitions := taskDefinitions collect: [ :def | 
		                   def metaparameters: aDictionary ].
	patchDefinition := patchDefinition metaparameters: aDictionary.
	icons := icons copy
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> name [
	^ metadata name
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> name: aString [

	metadata name: aString
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> north [
	^ self patchLength * self patchYDivisions
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> patchArea [
	^ self patchLength squared
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

{ #category : #'accessing - patch' }
RMDSimulationModel >> patchLength [
	^ simulationDefinition patchInitializer length
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> patchLengthUnit [

	^ simulationDefinition patchInitializer size unit
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> patchXDivisions [
	^ simulationDefinition patchInitializer xDivisions
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> patchYDivisions [
	^ simulationDefinition patchInitializer yDivisions
]

{ #category : #copying }
RMDSimulationModel >> postCopy [

	metadata := metadata copy.
	variability := variability copy.
	simulationDefinition := simulationDefinition copy.
	animatDefinitions := (animatDefinitions associations collect: [ 
		                      :assoc | assoc key -> assoc value copy ])
		                     asOrderedDictionary.
	worldDefinition := worldDefinition copy.
	actionDefinitions := (actionDefinitions associations collect: [ 
		                      :assoc | assoc key -> assoc value copy ])
		                     asOrderedDictionary.
	renderers := renderers collect: [ :renderer | renderer copy ].
	taskDefinitions := taskDefinitions collect: #copy.
	patchDefinition := patchDefinition copy.
	icons := icons copy
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

{ #category : #'accessing - icons' }
RMDSimulationModel >> removeIconAt: aString ifAbsent: errorBlock [

	^ icons removeKey: aString ifAbsent: errorBlock
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

{ #category : #'accessing - icons' }
RMDSimulationModel >> removeUnusedIcons [

	| names |
	names := Set new: icons size + 4.
	renderers do: [ :renderer | 
		renderer iconNamesDo: [ :iconName | names add: iconName ] ].
	icons keysAndValuesRemove: [ :name :form | 
		(names includes: name) not ]
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> renameAnimat: aString to: anotherString [

	(animatDefinitions includesKey: aString) ifFalse: [ ^ self ].
	(animatDefinitions includesKey: anotherString) ifTrue: [ ^ self ].
	simulationDefinition renameAnimat: aString to: anotherString.
	animatDefinitions valuesDo: [ :animatDef | 
		animatDef renameAnimat: aString to: anotherString ].
	animatDefinitions := (animatDefinitions values collect: [ :def | 
		                      def identifier -> def ]) asOrderedDictionary.
	actionDefinitions valuesDo: [ :actionDef | 
		actionDef renameAnimat: aString to: anotherString ].
	taskDefinitions do: [ :taskDef | 
		taskDef renameAnimat: aString to: anotherString ].
	renderers do: [ :renderer | 
		renderer renameAnimat: aString to: anotherString ]
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> renameSpecies: aString to: anotherString [

	(animatDefinitions anySatisfy: [ :animatDef | 
		 animatDef species = aString ]) ifFalse: [ ^ self ].
	(animatDefinitions anySatisfy: [ :animatDef | 
		 animatDef species = anotherString ]) ifTrue: [ ^ self ].
	animatDefinitions do: [ :animatDef | 
		animatDef species = aString ifTrue: [ 
			animatDef species: anotherString ] ]
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> renderers [
	^ renderers
]

{ #category : #enumerating }
RMDSimulationModel >> renderersDo: aBlock [
	renderers do: aBlock
]

{ #category : #rewriting }
RMDSimulationModel >> replaceChildren: aDictionary [

	metadata := metadata copy.
	simulationDefinition := simulationDefinition copyReplace: aDictionary.
	animatDefinitions := (animatDefinitions associations collect: [ 
		                      :assoc | assoc key -> assoc value copy ])
		                     asOrderedDictionary.
	worldDefinition := worldDefinition copy.
	actionDefinitions := (actionDefinitions associations collect: [ 
		                      :assoc | assoc key -> assoc value copy ])
		                     asOrderedDictionary.
	renderers := renderers collect: [ :renderer | renderer copy ].
	taskDefinitions := (taskDefinitions associations collect: [ :assoc | 
		                    assoc key -> assoc value copy ])
		                   asOrderedDictionary.
	patchDefinition := patchDefinition copy.
	icons := icons copy
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

	metadata := RMDMetadata new.
	variability := RMDVariabilityNode new.
	simulationDefinition := RMDSimulationDefinitionNode empty.
	patchDefinition := RMDPatchDefinitionNode empty.
	worldDefinition := RMDWorldDefinitionNode empty.
	animatDefinitions := OrderedDictionary new.
	actionDefinitions := OrderedDictionary new.
	taskDefinitions := OrderedCollection new.
	renderers := OrderedCollection new.
	icons := Dictionary new
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition [
	^ simulationDefinition
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> simulationDefinition: aRMDSimulationDefinition [
	simulationDefinition := aRMDSimulationDefinition
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> south [
	^ 0.0
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> speciesNames [

	| names |
	names := OrderedCollection new.
	animatDefinitions valuesDo: [ :animatDef | 
		| speciesName |
		speciesName := animatDef species.
		(names includes: speciesName) ifFalse: [ names add: speciesName ] ].
	^ names asArray
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> stageNamesOf: aString [

	^ (animatDefinitions values
		  select: [ :animat | animat species = aString ]
		  thenCollect: #identifier) asArray
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> stagesOf: aString [

	^ animatDefinitions
		  at: aString
		  ifPresent: [ :def | { def } ]
		  ifAbsent: [
			  (animatDefinitions values select: [ :animat |
				   animat species = aString ]) asArray ]
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> stagesOf: aString do: aBlock [

	animatDefinitions at: aString ifPresent: aBlock ifAbsent: [
		animatDefinitions valuesDo: [ :animat |
			animat species = aString ifTrue: [ aBlock value: animat ] ] ]
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> swapTasks: aRMDTaskDefinitionNode and: anotherRMDTaskDefinitionNode [

	| index1 index2 |
	index1 := taskDefinitions
		          indexOf: aRMDTaskDefinitionNode
		          ifAbsent: [ ^ nil ].
	index2 := taskDefinitions
		          indexOf: anotherRMDTaskDefinitionNode
		          ifAbsent: [ ^ nil ].
	taskDefinitions at: index1 put: anotherRMDTaskDefinitionNode.
	taskDefinitions at: index2 put: aRMDTaskDefinitionNode
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> taskDefinitions [
	^ Array withAll: taskDefinitions
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> taskDefinitions: aCollectionOfRMDTaskDefinitionNode [

	taskDefinitions := OrderedCollection withAll:
		                   aCollectionOfRMDTaskDefinitionNode
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
	self typechecker typecheckAll
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

{ #category : #private }
RMDSimulationModel >> updateMetaParameters [

	| freePlaceholders boundPlaceholders |
	freePlaceholders := Set new.
	simulationDefinition
		nodesSuchThat: #isPlaceholderNode
		do: [ :placeholder | freePlaceholders add: placeholder ].
	worldDefinition
		nodesSuchThat: #isPlaceholderNode
		do: [ :placeholder | freePlaceholders add: placeholder ].
	patchDefinition
		nodesSuchThat: #isPlaceholderNode
		do: [ :placeholder | freePlaceholders add: placeholder ].
	animatDefinitions valuesDo: [ :animatDefinition | 
		animatDefinition
			nodesSuchThat: #isPlaceholderNode
			do: [ :placeholder | freePlaceholders add: placeholder ] ].
	taskDefinitions do: [ :taskDefinition | 
		(taskDefinition actionWith: self)
			nodesSuchThat: #isPlaceholderNode
			do: [ :placeholder | freePlaceholders add: placeholder ] ].
	boundPlaceholders := OrderedCollection new.
	variability metaParameterSequences do: [ :metaParameterSequence | 
		metaParameterSequence placeholdersDo: [ :placeholder | 
			boundPlaceholders add: placeholder ] ].
	variability
		removePlaceholders: boundPlaceholders \ freePlaceholders;
		addPlaceholders: freePlaceholders asArray \ boundPlaceholders
]

{ #category : #'accessing - metadata' }
RMDSimulationModel >> updateMetadata [

	metadata
		ensureCurrentAuthor;
		updateDate
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> variability [

	^ variability
]

{ #category : #'accessing - definitions' }
RMDSimulationModel >> variability: aRMDVariabilityNode [

	variability := aRMDVariabilityNode
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> west [
	^ 0.0
]

{ #category : #'accessing - patch' }
RMDSimulationModel >> worldArea [

	^ self patchArea * self patchXDivisions * self patchYDivisions
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
