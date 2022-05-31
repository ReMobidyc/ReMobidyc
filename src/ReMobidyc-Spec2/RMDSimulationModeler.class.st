Class {
	#name : #RMDSimulationModeler,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'views',
		'runOnMemoryButton',
		'runOnFileButton',
		'simulationDefinitionPresenter',
		'menuBar',
		'modelFileReference'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #layout }
RMDSimulationModeler class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self toolbarHeight;
		  add: (SpBoxLayout newHorizontal
				   add: #runOnMemoryButton;
				   add: #runOnFileButton)
		  height: self buttonHeight;
		  add: #views yourself;
		  yourself
]

{ #category : #examples }
RMDSimulationModeler class >> goatAndWolf [

	<script: 'RMDSimulationModeler goatAndWolf openWithSpec'>
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
				label: 'Modeler';
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
						help: 'A simple simulation of plants, herbivore, and carnivore.' ].
			(aBuilder item: #ReMobidycSystem)
				parent: 'ReMobidyc';
				label: 'System';
				with: [ 
					(aBuilder item: #Upgrade)
						parent: #ReMobidycSystem;
						label: 'Upgrade from the official repository';
						action: [ 
							EpMonitor disableDuring: [ 
									Metacello new
										onConflictUseLoaded;
										onWarningLog;
										repository: 'github://ReMobidyc/ReMobidyc:main/';
										baseline: 'ReMobidyc';
										get;
										load ] ];
						help:
						'Upgrade the re:mobidyc from the official github repository.' ] ]
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
										  expression:
										  (RMDLiteralNode literal: '0' unit: attribute unit) ])) ] ] ]
]

{ #category : #private }
RMDSimulationModeler >> addAnimatNamed: aString [

	| name animatDefinitionNode |
	name := RMDGrammar new agentIdentifier end parse: aString.
	name isPetit2Failure ifTrue: [ 
		UIManager default alert: 'Invalid animat name: ' , aString.
		^ nil ].
	(simulationModel animatDefinitionAt: name ifAbsent: [ nil ]) 
		ifNotNil: [ 
			UIManager default alert: name , ' is already defined.'.
			^ nil ].
	animatDefinitionNode := RMDAnimatDefinitionNode
		                        identifier: name
		                        attributeDeclarations: Array new.
	simulationModel load: animatDefinitionNode.
	simulationModel addRenderer:
		(RMDAnimatDotRenderer on: name diameter: 7 color: Color yellow).
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
					  name: 'Load...';
					  action: [ 
						  RMDRepositoryModelsBrowser openToLoadDo: [ :model :repBrowser | 
								  self
									  setSimulationModel: model;
									  modelFileReference: repBrowser file ] ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Save As...';
					  action: [ 
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
	views := self newNotebook
		         whenSelectedPageChangedDo: [ 
			         simulationDefinitionPresenter ifNotNil: #nodeChanged ];
		         whenPageRemovedDo: [ :page | 
			         self removeAnimatNamed: page title ];
		         yourself.
	runOnMemoryButton := self newButton
		                     label: 'Run';
		                     action: [ self openObservatory ];
		                     state: false;
		                     yourself.
	runOnFileButton := self newButton
		                   label: 'Run & Record';
		                   action: [ self openObservatoryOnDirectory ];
		                   state: false;
		                   yourself
]

{ #category : #initialization }
RMDSimulationModeler >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: self windowTitle;
		initialExtent: 800 @ 600
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

{ #category : #api }
RMDSimulationModeler >> openObservatory [

	| interpreter |
	interpreter := RMDInterpreter new
		               setMemory: RMDOnMemory new;
		               setContext: RMDActionContext new;
		               simulationModel: simulationModel;
		               yourself.
	interpreter setupSimulation.
	^ (RMDObservatory interpreter: interpreter)
		  modelName:
			  (modelFileReference ifNotNil: [ modelFileReference basename ]);
		  open;
		  yourself
]

{ #category : #api }
RMDSimulationModeler >> openObservatoryOnDirectory [

	RMDRepositoryModelsBrowser
		openForSave: simulationModel
		ifAccepted: [ :ref | self openObservatoryOnDirectory: ref ]
]

{ #category : #api }
RMDSimulationModeler >> openObservatoryOnDirectory: aFileReference [

	| memoryRef interpreter |
	memoryRef := aFileReference / 'memory'.
	memoryRef isDirectory ifTrue: [ 
		(UIManager default
			 confirm:
			 'A simulation result of the model is already stored. Do you want to erase the existing result?'
			 label: 'Simulation result exists'
			 trueChoice: 'Erase & Open'
			 falseChoice: 'Open'
			 cancelChoice: 'Cancel'
			 default: false)
			ifNil: [ ^ self ]
			ifNotNil: [ :choice | choice ifTrue: [ memoryRef ensureDeleteAll ] ] ].
	interpreter := RMDInterpreter new
		               setMemory:
			               (RMDFileMemory on: memoryRef ensureCreateDirectory);
		               setContext: RMDActionContext new;
		               simulationModel: simulationModel;
		               yourself.
	interpreter setupSimulation.
	^ (RMDObservatory interpreter: interpreter)
		  modelName: aFileReference basename;
		  open;
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
RMDSimulationModeler >> setSimulationModel: aRMDSimulationModel [
	simulationModel := aRMDSimulationModel.
	simulationDefinitionPresenter
		ifNotNil: [ simulationDefinitionPresenter
				node: (simulationModel ifNotNil: #simulationDefinition) ].
	self updatePages
]

{ #category : #private }
RMDSimulationModeler >> updatePages [

	| selection |
	selection := views selectedPageIndex.

	views pages: (Array streamContents: [ :stream | 
			 stream
				 nextPut: (SpNotebookPage title: 'Simulation Conditions' provider: [ 
							  RMDScrollPresenter with:
									  (simulationDefinitionPresenter := (RMDSimulationDefinitionPresenter 
										                                     on:
											                                     (simulationModel 
												                                      ifNotNil:
													                                      #simulationDefinition))
										                                    
										                                    addAnimatInitializerAction: [ 
											                                    self
												                                    addAnimatInitializer ];
										                                    yourself) ]);
				 nextPut: (SpNotebookPage
						  title: 'World'
						  provider: [ RMDWorldDefinitionBrowser on: simulationModel ]);
				 nextPut: (SpNotebookPage
						  title: 'Patch'
						  provider: [ RMDPatchDefinitionBrowser on: simulationModel ]).

			 simulationModel animatNames do: [ :animat | 
				 stream
					 nextPut: (SpNotebookPage
							  title: animat
							  provider: [ 
								  RMDAnimatDefinitionBrowser
									  on: simulationModel
									  animat: animat ]) beCloseable;
					 yourself ].
			 stream nextPut:
				 (SpNotebookPage
					  title: ''
					  icon: Smalltalk ui icons add
					  provider: [ 
						  RMDAddAnimatEditor new
							  action: [ :name | self addAnimatNamed: name ];
							  yourself ]) ]).
	selection > 0 ifTrue: [ 
		views selectPageIndex: (selection min: views pages size) ]
]

{ #category : #private }
RMDSimulationModeler >> updateWindowTitle [

	self window ifNotNil: [ :window | window title: self windowTitle ]
]

{ #category : #private }
RMDSimulationModeler >> windowTitle [

	^ 'Modeler' , (modelFileReference
		   ifNil: [ '' ]
		   ifNotNil: [ ' @ ' , modelFileReference basename ])
]
