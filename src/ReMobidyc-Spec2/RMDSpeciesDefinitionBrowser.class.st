Class {
	#name : #RMDSpeciesDefinitionBrowser,
	#superclass : #RMDPresenter,
	#instVars : [
		'stagesNotebook',
		'species',
		'modeler'
	],
	#category : #'ReMobidyc-Spec2-Components'
}

{ #category : #layout }
RMDSpeciesDefinitionBrowser class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #stagesNotebook;
		  yourself
]

{ #category : #'instance creation' }
RMDSpeciesDefinitionBrowser class >> on: aRMDSimulationModeler species: aString [

	^ self new
		  modeler: aRMDSimulationModeler;
		  species: aString;
		  yourself
]

{ #category : #initialization }
RMDSpeciesDefinitionBrowser >> initializePresenters [

	super initializePresenters.
	stagesNotebook := self newNotebook
		                  whenSelectedPageChangedDo: [ 
			                  modeler ifNotNil: [ 
					                  modeler simulationDefinitionPresenter 
						                  ifNotNil: #nodeChanged ] ];
		                  whenPageRemovedDo: [ :page | 
			                  modeler ifNotNil: [ 
					                  modeler removeAnimatNamed: page title ] ];
		                  yourself.
	self updateStages
]

{ #category : #accessing }
RMDSpeciesDefinitionBrowser >> modeler [

	^ modeler
]

{ #category : #accessing }
RMDSpeciesDefinitionBrowser >> modeler: aRMDSimulationModeler [

	modeler := aRMDSimulationModeler.
	self updateStages
]

{ #category : #accessing }
RMDSpeciesDefinitionBrowser >> species [

	^ species
]

{ #category : #accessing }
RMDSpeciesDefinitionBrowser >> species: aString [

	species := aString.
	self updateStages
]

{ #category : #updating }
RMDSpeciesDefinitionBrowser >> updateStages [

	| selection |
	(modeler isNil or: [ species isNil or: [ stagesNotebook isNil ] ]) 
		ifTrue: [ ^ self ].
	selection := stagesNotebook selectedPageIndex.
	stagesNotebook pages:
		(((modeler simulationModel stagesOf: species) collect: [ :stageName | 
			  (SpNotebookPage title: stageName provider: [ 
					   RMDAnimatDefinitionBrowser
						   on: modeler simulationModel
						   animat: stageName ])
				  beCloseable;
				  yourself ]) copyWith:
			 (SpNotebookPage
				  title: ''
				  icon: Smalltalk ui icons add
				  provider: [ 
					  RMDAddStageEditor new
						  action: [ :stage | 
							  modeler addAnimatNamed: stage species: species ];
						  yourself ]))
]
