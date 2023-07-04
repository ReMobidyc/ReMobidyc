Class {
	#name : #RMDSimulationDefinitionPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#instVars : [
		'addInitializerButton',
		'addAnimatInitializerAction'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSimulationDefinitionPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		spacing: 10;
		add: 'N/A' expand: false;
		yourself
]

{ #category : #private }
RMDSimulationDefinitionPresenter >> addAnimatInitializer [
	addAnimatInitializerAction ifNotNil: #value.
	self nodeChanged
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> addAnimatInitializerAction [

	^ addAnimatInitializerAction
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> addAnimatInitializerAction: aBlock [

	addAnimatInitializerAction := aBlock
]

{ #category : #icons }
RMDSimulationDefinitionPresenter >> addDataSourceIcon [

	| form green |
	form := Form extent: self addIcon extent + (8 @ 0) depth: 32.
	green := Color green adjustBrightness: -0.5.
	form getCanvas
		drawImage: self historyIcon at: 8 @ 0;
		fillRectangle: (0 @ 4 extent: 10 @ 2) color: green;
		fillRectangle: (4 @ 0 extent: 2 @ 10) color: green;
		flush.
	^ form
]

{ #category : #operations }
RMDSimulationDefinitionPresenter >> addWorldDataSource [

	RMDRepositoryDataBrowser openToLoadDo: [ :fileReference |
		| importer |
		(importer := RMDCSVImporter on: fileReference) openDialog okAction: [
			node worldDataSource: importer outputDataSource.
			self nodeChanged ] ]
]

{ #category : #initialization }
RMDSimulationDefinitionPresenter >> initializePresenters [

	super initializePresenters.
	addInitializerButton := self newButton
		                        label: '';
		                        icon: self addIcon;
		                        action: [ self addAnimatInitializer ];
		                        color: Color white;
		                        yourself.
	self whenBuiltDo: [ self nodeChanged ]
]

{ #category : #initialization }
RMDSimulationDefinitionPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Simulation Definition';
		initialExtent: 600 @ 400
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> newLayout [

	| newLayout |
	newLayout := SpBoxLayout newVertical
		             spacing: 15;
		             yourself.
	newLayout
		add: node timeDefinition asPresenter
		height: self class buttonHeight;
		add: node worldInitializer asPresenter expand: false;
		add: (SpBoxLayout newHorizontal
				 add: (self newButton
						  icon: self tabularIcon;
						  label: 'data source';
						  help: 'Preview world data source';
						  action: [ self previewWorldDataSource ];
						  enabled: node worldDataSource notNil;
						  yourself)
				 expand: false;
				 add: (self newButton
						  icon: self addIcon;
						  help: 'Add world data source';
						  action: [ self addWorldDataSource ];
						  enabled: node worldDataSource isNil;
						  yourself)
				 width: self class buttonHeight;
				 add: (self newButton
						  icon: self removeIcon;
						  help: 'Remove world data source';
						  enabled: node worldDataSource notNil;
						  action: [ self removeWorldDataSource ];
						  yourself)
				 width: self class buttonHeight;
				 yourself)
		expand: false;
		add: node patchInitializer asPresenter expand: false.
	node animatInitializers do: [ :initializer |
		newLayout
			add: (initializer asPresenter
					 removeButtonAction: [ self removeAnimatInitializer: initializer ];
					 yourself)
			expand: false ].
	newLayout add: addInitializerButton expand: false.
	^ newLayout
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> nodeChanged [

	self layout: self newLayout
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> preferredHeight [
	^ (layout presenters collect: #preferredHeight) sum
]

{ #category : #operations }
RMDSimulationDefinitionPresenter >> previewWorldDataSource [

	(node ifNotNil: #worldDataSource) ifNotNil: [ :dataSource |
		dataSource originalDataFrame ifNotNil: [ :dataFrame |
			(self newTable
				 columns: (dataFrame columnNames collect: [ :name |
							  SpStringTableColumn
								  title: name
								  evaluated: [ :row | row at: name ] ]);
				 items: dataFrame rows;
				 openDialog) title: 'World Data Source' ] ]
]

{ #category : #private }
RMDSimulationDefinitionPresenter >> removeAnimatInitializer: aRMDAnimatInitializerNode [

	node animatInitializers:
		(node animatInitializers copyWithout: aRMDAnimatInitializerNode).
	self nodeChanged
]

{ #category : #operations }
RMDSimulationDefinitionPresenter >> removeWorldDataSource [

	(UIManager default
		 confirm: 'Remove the world data source?'
		 label: 'Confirmation') ifTrue: [
		node worldDataSource: nil.
		self nodeChanged ]
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> worldDataSourceLabel [

	^ node worldDataSource
		  ifNotNil: [ :dataSource |
		  ',' join: dataSource dataFrame columnNames ]
		  ifNil: [ '' ]
]
