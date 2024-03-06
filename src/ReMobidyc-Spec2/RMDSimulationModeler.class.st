Class {
	#name : #RMDSimulationModeler,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'views',
		'simulationDefinitionPresenter',
		'menuBar',
		'modelFileReference',
		'metadataPresenter',
		'saveButton',
		'openExperimentariumButton',
		'openExperimentariumMenuButton',
		'variabilityPresenter',
		'canDiscardEdits'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDSimulationModeler class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self toolbarHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #saveButton width: self buttonHeight;
				   addSpace;
				   addButton: #openExperimentariumButton
				   dropdownButton: #openExperimentariumMenuButton;
				   yourself)
		  height: self buttonHeight;
		  add: #views yourself;
		  yourself
]

{ #category : #examples }
RMDSimulationModeler class >> goatAndWolf [

	<script: 'RMDSimulationModeler goatAndWolf open'>
	^ RMDSimulationModeler on: RMDSimulationModel goatAndWolf
]

{ #category : #'instance creation' }
RMDSimulationModeler class >> on: aRMDSimulationModel [
	^ self new
		setSimulationModel: aRMDSimulationModel;
		yourself
]

{ #category : #menus }
RMDSimulationModeler class >> remobidycMenuOn: aBuilder [

	<worldMenu>
	(aBuilder item: #ReMobidyc)
		label: 're:Mobidyc';
		order: 1;
		with: [ 
			(aBuilder item: #OpenNew)
				parent: 'ReMobidyc';
				order: 1;
				label: 'Modeler (GUI)';
				action: [ 
					(RMDSimulationModeler on: (RMDSimulationModel new
								  addRenderer: (RMDBackgroundColorRenderer color: Color black);
								  addRenderer: (RMDPatchColorAlphaRenderer
										   color: Color green
										   alpha: '0.5' asRMDExpression
										   between: '0.0' asRMDExpression
										   and: '1.0' asRMDExpression);
								  yourself)) open ];
				help: 'Open a modeler window with a new simulation model'.
			(aBuilder item: #Examples)
				parent: 'ReMobidyc';
				order: 99;
				label: 'Examples';
				with: [ 
					(aBuilder item: #SugarScape)
						parent: #Examples;
						label: 'sugar scape';
						action: [ RMDSimulationModeler sugarScape open ];
						help: 'A simple simulation of an energy cycle.'.
					(aBuilder item: #GoatAndWolf)
						parent: #Examples;
						label: 'goat and wolf';
						action: [ RMDSimulationModeler goatAndWolf open ];
						help: 'A simple simulation of plants, herbivore, and carnivore.' ] ]
]

{ #category : #examples }
RMDSimulationModeler class >> sugarScape [
	<script: 'RMDSimulationModeler sugarScape openWithSpec'>
	^ RMDSimulationModeler on: RMDSimulationModel sugarScape
]

{ #category : #private }
RMDSimulationModeler >> addAnimatInitializer [

	| animatNames |
	animatNames := simulationModel animatNames.
	(UIManager default
		 chooseFrom: animatNames
		 title: 'Choose an animat to initially place') ifNotNil: [ :index | 
		(animatNames at: index ifAbsent: [ nil ]) ifNotNil: [ :animatName | 
			(simulationModel animatDefinitionAt: animatName ifAbsent: [ nil ]) 
				ifNotNil: [ :animatDefinition | 
					simulationModel simulationDefinition addAnimatInitializer:
						(RMDAnimatInitializerNode
							 population: 0
							 animat: animatName
							 attributeInitializers:
								 (animatDefinition allAttributeDeclarations collect: [ 
									  :attribute | 
									  RMDAttributeInitializerNode
										  identifier: attribute identifier
										  expression: nil ])
							 utilityDefinitions: Array new) ] ] ]
]

{ #category : #private }
RMDSimulationModeler >> addAnimatNamed: aString species: anotherString [

	| stageName speciesName animatDefinitionNode |
	stageName := RMDGrammar current agentIdentifier end parse: aString.
	stageName isPetit2Failure ifTrue: [ 
		UIManager default alert: 'Invalid animat name: ' , aString.
		^ nil ].
	speciesName := RMDGrammar current agentIdentifier end parse:
		               anotherString.
	speciesName isPetit2Failure ifTrue: [ 
		UIManager default alert: 'Invalid animat name: ' , anotherString.
		^ nil ].
	(simulationModel animatDefinitionAt: stageName ifAbsent: [ nil ]) 
		ifNotNil: [ 
			UIManager default alert: stageName , ' is already defined.'.
			^ nil ].
	animatDefinitionNode := RMDAnimatDefinitionNode
		                        identifier: stageName
		                        species: speciesName
		                        attributeDeclarations: Array new
		                        utilityDefinitions: Array new.
	simulationModel load: animatDefinitionNode.
	simulationModel addRenderer:
		(RMDAnimatDotRenderer on: stageName shapeSize: 7 color: Color yellow).
	self updatePages
]

{ #category : #operations }
RMDSimulationModeler >> addNewIconDo: aBlock [

	| icons |
	icons := simulationModel iconNames asSet.
	RMDRepositoryIconsBrowser openToLoadDo: [ :form :browser | 
		| iconName |
		iconName := ''.
		[ iconName = '' ] whileTrue: [ 
			iconName := (UIManager default
				             request: 'Icon name'
				             initialAnswer: browser file basename) ifNotNil: [ 
				            :name | 
				            (icons includes: name)
					            ifTrue: [ '' ]
					            ifFalse: [ name ] ] ].
		(iconName endsWith: '.png') ifFalse: [ 
			iconName := iconName , '.png' ].
		simulationModel iconAt: iconName put: form.
		aBlock value: iconName ]
]

{ #category : #operations }
RMDSimulationModeler >> copyStage: aString to: anotherString [

	(self simulationModel animatDefinitionAt: aString ifAbsent: [ nil ]) 
		ifNil: [ 
			UIManager default alert: 'No animat named ' , aString.
			^ self ].
	(self simulationModel
		 animatDefinitionAt: anotherString
		 ifAbsent: [ nil ]) ifNotNil: [ 
		UIManager default alert:
			'The stage ' , anotherString , ' already exists.'.
		^ self ].
	self simulationModel copyAnimat: aString to: anotherString.
	self updatePages
]

{ #category : #menu }
RMDSimulationModeler >> fileMenu [

	^ self newMenu
		  addGroup: [ :group | 
			  group addItem: [ :item | 
					  item
						  name: 'New';
						  action: [ 
							  self
								  setSimulationModel: (RMDSimulationModel new
										   addRenderer:
											   (RMDBackgroundColorRenderer color: Color black);
										   addRenderer: (RMDPatchColorAlphaRenderer
												    color: Color green
												    alpha: '0.5' asRMDExpression
												    between: '0.0' asRMDExpression
												    and: '1.0' asRMDExpression);
										   yourself);
								  modelFileReference: nil ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Open...';
					  action: [ 
						  RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
								  self
									  setSimulationModel: model;
									  modelFileReference: repBrowser file ] ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Save';
					  enabled: [ modelFileReference notNil ];
					  action: [ 
						  simulationModel updateMetadata.
						  metadataPresenter metadataChanged.
						  simulationModel exportModel: modelFileReference ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Save As...';
					  action: [ 
						  simulationModel updateMetadata.
						  metadataPresenter metadataChanged.
						  RMDRepositoryModelsBrowser
							  openForSave: simulationModel
							  do: [ :model :repBrowser | 
								  self modelFileReference: repBrowser file ] ] ] ];
		  yourself
]

{ #category : #initialization }
RMDSimulationModeler >> initializePresenters [

	super initializePresenters.
	menuBar := self newMenuBar
		           addGroup: [ :group | 
			           group addItem: [ :item | 
					           item
						           name: 'File';
						           subMenu: self fileMenu ] ];
		           yourself.
	metadataPresenter := self newMetadata
		                     whenNameChangedDo: [ self updateWindowTitle ];
		                     yourself.

	views := self newNotebook
		         whenSelectedPageChangedDo: [ 
			         | pageIndex |
			         pageIndex := views selectedPageIndex.
			         pageIndex = self variabilityPageIndex ifTrue: [ 
					         simulationModel ifNotNil: #updateMetaParameters.
					         variabilityPresenter ifNotNil: #nodeChanged.
					         (views pageAt: self variabilityPageIndex) resetContent ].
			         pageIndex = self simulationDefinitionPageIndex ifTrue: [ 
					         simulationDefinitionPresenter ifNotNil: #nodeChanged ] ];
		         whenPageRemovedDo: [ :page | 
			         self removeSpeciesNamed: page title ];
		         yourself.
	saveButton := self newButton
		              icon: self saveIcon;
		              action: [ self save ];
		              help: 'Save the model to file';
		              yourself.
	openExperimentariumButton := self newButton
		                             icon: self experimentariumIcon;
		                             action: [ 
			                             simulationModel metaInterpreterOnFile 
				                             ifNotNil: #openInExperimentarium ];
		                             help:
			                             'Run the model in an experimentarium.';
		                             yourself.
	openExperimentariumMenuButton := self newButton
		                                 icon: self dropdownIcon;
		                                 action: [ 
			                                 self openInExperimentarium ];
		                                 help:
			                                 'Run the model in an experimentarium with selected memory model.';
		                                 yourself
]

{ #category : #initialization }
RMDSimulationModeler >> initializeWindow: aWindowPresenter [

	| cachedAns |
	cachedAns := nil.
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 1000 @ 600.
	aWindowPresenter whenWillCloseDo: [ :willCloseAnnouncement |
		cachedAns ifNil: [
			cachedAns := true.
			(willCloseAnnouncement canClose and: [
				 UIManager default
					 confirm: 'Export the model before close?'
					 orCancel: [
						 willCloseAnnouncement denyClose.
						 cachedAns := nil.
						 false ] ]) ifTrue: [ self save ] ] ]
]

{ #category : #private }
RMDSimulationModeler >> metadataPageIndex [
	^ 1
]

{ #category : #accessing }
RMDSimulationModeler >> modelFileReference [

	^ modelFileReference
]

{ #category : #accessing }
RMDSimulationModeler >> modelFileReference: aFileReferenceOrNil [

	modelFileReference := aFileReferenceOrNil.
	self updateWindowTitle
]

{ #category : #operations }
RMDSimulationModeler >> open [

	Cursor wait showWhile: [ ^ super open ]
]

{ #category : #operations }
RMDSimulationModeler >> openInExperimentarium [

	self openInExperimentariumMenu openWithSpecAtPointer
]

{ #category : #operations }
RMDSimulationModeler >> openInExperimentariumMenu [

	^ self newMenu
		  title: 'Experimentarium';
		  addGroup: [ :group | 
			  group
				  addItem: [ :item | 
					  item
						  name: 'Dry-run';
						  action: [ 
							  simulationModel metaInterpreterForDryRun ifNotNil:
									  #openInExperimentarium ] ];
				  addItem: [ :item | 
					  item
						  name: 'On file';
						  action: [ 
							  simulationModel metaInterpreterOnFile ifNotNil:
									  #openInExperimentarium ] ] ];
		  yourself
]

{ #category : #private }
RMDSimulationModeler >> removeAnimatNamed: aString [

	(simulationModel animatDefinitionAt: aString ifAbsent: [ nil ])
		ifNil: [ 
			UIManager default alert: aString , ' is not defined.'.
			^ nil ]
		ifNotNil: [ 
			(UIManager default
				 confirm: 'Sure to remove ' , aString , '?'
				 label: 'Confirmation to remove animat') ifTrue: [ 
				simulationModel removeAnimat: aString ifAbsent: [  ] ].
			self updatePages ]
]

{ #category : #private }
RMDSimulationModeler >> removeSpeciesNamed: aString [

	| stages |
	stages := (simulationModel animatDefinitions values
		           select: [ :animat | animat species = aString ]
		           thenCollect: #identifier) asSortedCollection asArray.
	stages ifNotEmpty: [ 
		(UIManager default
			 confirm: 'Sure to remove ' , (', ' join: stages) , '?'
			 label: 'Confirmation to remove species definitions') ifTrue: [ 
			stages do: [ :stage | 
				simulationModel removeAnimat: stage ifAbsent: [  ] ] ].
		self updatePages ]
]

{ #category : #operations }
RMDSimulationModeler >> renameSpecies: aString to: anotherString [

	| stages |
	stages := self simulationModel stageNamesOf: aString.
	stages ifEmpty: [ 
		UIManager default alert: 'No species named ' , aString.
		^ self ].
	(self simulationModel stageNamesOf: anotherString) ifNotEmpty: [ 
		UIManager default alert:
			'The species ' , anotherString , ' already exists.'.
		^ self ].
	self simulationModel renameSpecies: aString to: anotherString.
	self updatePages
]

{ #category : #operations }
RMDSimulationModeler >> renameStage: aString to: anotherString [

	(self simulationModel animatDefinitionAt: aString ifAbsent: [ nil ]) 
		ifNil: [ 
			UIManager default alert: 'No animat named ' , aString.
			^ self ].
	(self simulationModel
		 animatDefinitionAt: anotherString
		 ifAbsent: [ nil ]) ifNotNil: [ 
		UIManager default alert:
			'The stage ' , anotherString , ' already exists.'.
		^ self ].
	self simulationModel renameAnimat: aString to: anotherString.
	self updatePages
]

{ #category : #operations }
RMDSimulationModeler >> save [

	modelFileReference ifNil: [
		RMDRepositoryModelsBrowser
			openForSave: simulationModel
			do: [ :model :repBrowser |
			self modelFileReference: repBrowser file ] ].
	modelFileReference ifNil: [ ^ self ].
	simulationModel updateMetadata.
	metadataPresenter metadataChanged.
	simulationModel exportModel: modelFileReference
]

{ #category : #private }
RMDSimulationModeler >> setSimulationModel: aRMDSimulationModel [

	simulationModel := aRMDSimulationModel.
	metadataPresenter ifNotNil: [
		simulationModel ifNotNil: [
			metadataPresenter metadata: simulationModel metadata ] ].
	simulationDefinitionPresenter ifNotNil: [
		simulationDefinitionPresenter node:
			(simulationModel ifNotNil: #simulationDefinition) ].
	self updatePages
]

{ #category : #private }
RMDSimulationModeler >> simulationDefinitionPageIndex [
	^ 3
]

{ #category : #accessing }
RMDSimulationModeler >> simulationDefinitionPresenter [

	^ simulationDefinitionPresenter
]

{ #category : #accessing }
RMDSimulationModeler >> simulationModel [

	^ simulationModel
]

{ #category : #private }
RMDSimulationModeler >> title [

	^ 'Modeler'
	  ,
		  ((simulationModel ifNotNil: #name ifNil: '') ifNotEmpty: [ :name | 
			   ' @ ' , name ])
]

{ #category : #private }
RMDSimulationModeler >> updatePages [

	| selection |
	selection := views selectedPageIndex.
	views pages: (Array streamContents: [ :stream |
			 stream
				 nextPut:
					 (SpNotebookPage
						  title: 'Metadata'
						  provider: [ metadataPresenter ]);
				 nextPut: (SpNotebookPage title: 'Variability' provider: [
							  variabilityPresenter := RMDVariabilityPresenter on:
									                          (simulationModel
										                           updateMetaParameters;
										                           variability) ]);
				 nextPut:
					 (SpNotebookPage title: 'Simulation Conditions' provider: [
						  RMDScrollPresenter with:
							  (simulationDefinitionPresenter := (RMDSimulationDefinitionPresenter
								                                     on:
									                                     (simulationModel
										                                      ifNotNil:
											                                      #simulationDefinition))
								
								                                    addAnimatInitializerAction: [
									                                    self addAnimatInitializer ];
								                                    yourself) ]);
				 nextPut: (SpNotebookPage
						  title: 'World'
						  provider: [ RMDWorldDefinitionBrowser on: self ]);
				 nextPut: (SpNotebookPage
						  title: 'Patch'
						  provider: [ RMDPatchDefinitionBrowser on: self ]).
			 simulationModel speciesNames do: [ :speciesName |
				 | pageIndex |
				 pageIndex := ((views pages
					                detect: [ :page | page title = speciesName ]
					                ifNone: [ nil ]) ifNotNil: #activePresenter)
					              ifNotNil: #selectedPageIndex
					              ifNil: [ 0 ].
				 stream
					 nextPut: (SpNotebookPage title: speciesName provider: [
								  (RMDSpeciesDefinitionBrowser on: self species: speciesName)
									  selectPageIndex: pageIndex ]) beCloseable;
					 yourself ].
			 stream nextPut:
				 (SpNotebookPage title: '' icon: self addIcon provider: [
					  RMDAddSpeciesEditor new
						  action: [ :speciesName :stageName |
							  self addAnimatNamed: stageName species: speciesName ];
						  yourself ]) ]).
	selection > 0 ifTrue: [
		views selectPageIndex: (selection min: views pages size) ]
]

{ #category : #private }
RMDSimulationModeler >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self title ]
]

{ #category : #private }
RMDSimulationModeler >> variabilityPageIndex [
	^ 2
]
