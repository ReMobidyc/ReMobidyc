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

{ #category : #initialization }
RMDSimulationDefinitionPresenter >> initializePresenters [

	super initializePresenters.
	addInitializerButton := self newButton
		                        label: '';
		                        icon: Smalltalk ui icons add;
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
		add: node timeDefinition asPresenter height: self class buttonHeight;
		add: node worldInitializer asPresenter expand: false;
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

{ #category : #private }
RMDSimulationDefinitionPresenter >> removeAnimatInitializer: aRMDAnimatInitializerNode [

	node animatInitializers:
		(node animatInitializers copyWithout: aRMDAnimatInitializerNode).
	self nodeChanged
]
