Class {
	#name : #RMDSimulationModeler,
	#superclass : #RMDPresenter,
	#instVars : [
		'simulationModel',
		'views',
		'runButton',
		'simulationDefinitionPresenter',
		'menuBar'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #specs }
RMDSimulationModeler class >> defaultSpec [

	^ SpBoxLayout newVertical
		  add: #menuBar height: self toolbarHeight;
		  add: #runButton height: self buttonHeight;
		  add: #views yourself;
		  yourself
]

{ #category : #examples }
RMDSimulationModeler class >> goatAndWolf [

	<script: 'RMDSimulationModeler goatAndWolf openWithSpec'>
	^ RMDSimulationModeler on: RMDSimulationModel goatAndWolf
]

{ #category : #menus }
RMDSimulationModeler class >> golapMenuOn: aBuilder [

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
								  addRenderer: (RMDCellColorAlphaRenderer
										   color: Color green
										   alpha: '0.5' asRMDExpression
										   between: '0.0' asRMDExpression
										   and: '1.0' asRMDExpression);
								  yourself)) openWithSpec ];
				help: 'Open a modeler window with a new simulation model'.
			(aBuilder item: #Examples)
				parent: 'ReMobidyc';
				label: 'Examples';
				with: [ 
					(aBuilder item: #SugarScape)
						parent: #Examples;
						label: 'sugar scape';
						action: [ RMDSimulationModeler sugarScape openWithSpec ];
						help: 'A simple simulation of an energy cycle.'.
					(aBuilder item: #GoatAndWolf)
						parent: #Examples;
						label: 'goat and wolf';
						action: [ RMDSimulationModeler goatAndWolf openWithSpec ];
						help: 'A simple simulation of plants, herbivore, and carnivore.' ] ]
]

{ #category : #'instance creation' }
RMDSimulationModeler class >> on: aRMDSimulationModel [
	^ self new
		setSimulationModel: aRMDSimulationModel;
		yourself
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
							 propertyInitializers:
								 (animatDefinition allPropertyDeclarations collect: [ 
									  :property | 
									  RMDPropertyInitializerNode
										  identifier: property identifier
										  expression:
										  (RMDLiteralNode literal: '0' unit: property unit) ])) ] ] ]
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
		                        propertyDeclarations: Array new.
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
						  name: 'Import...';
						  action: [ 
							  ([ RMDSimulationModel importModel ]
								   on: Error
								   do: [ :ex | ex return: nil ]) ifNotNil: [ :model | 
									  self setSimulationModel: model ] ] ].
			  group addItem: [ :item | 
				  item
					  name: 'Export As...';
					  action: [ simulationModel exportModel ] ] ];
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
	runButton := self newButton
		             label: 'run';
		             action: [ self openObservatory ];
		             state: false;
		             yourself
]

{ #category : #initialization }
RMDSimulationModeler >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Re:Mobidyc - Simulation Modeler';
		initialExtent: 800 @ 600
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
		  openWithSpec;
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
				 nextPut: (SpNotebookPage title: 'Time & Space' provider: [ 
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
						  title: 'Cell'
						  provider: [ RMDCellDefinitionBrowser on: simulationModel ]).

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

{ #category : #'api-events' }
RMDSimulationModeler >> whenRunStateChangedDo: aBlock [
	runButton whenStateChangedDo: aBlock
]
