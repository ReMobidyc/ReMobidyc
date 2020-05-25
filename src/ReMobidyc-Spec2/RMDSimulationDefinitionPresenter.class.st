Class {
	#name : #RMDSimulationDefinitionPresenter,
	#superclass : #RMDSyntaxNodePresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSimulationDefinitionPresenter class >> defaultSpec [
	<spec>
	^ SpScrollableLayout new
		add:
			(SpBoxLayout newVertical
				spacing: 10;
				add: 'N/A' expand: false;
				yourself);
		yourself
]

{ #category : #private }
RMDSimulationDefinitionPresenter >> add: aRMDSyntaxNodeEditor [
	self theLayout
		add: aRMDSyntaxNodeEditor
		height: aRMDSyntaxNodeEditor preferredHeight
]

{ #category : #initialization }
RMDSimulationDefinitionPresenter >> initializePresenters [
	self nodeChanged
]

{ #category : #initialization }
RMDSimulationDefinitionPresenter >> initializeWidgets [
	super initializeWidgets.
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
RMDSimulationDefinitionPresenter >> nodeChanged [
	layout
		ifNotNil: [ layout presenters first removeAll.
			self
				add: node timeDefinition asPresenter;
				add: node worldInitializer asPresenter;
				add: node cellInitializer asPresenter.
			node animatInitializers
				do: [ :initializer | self add: initializer asPresenter ] ]
]

{ #category : #accessing }
RMDSimulationDefinitionPresenter >> preferredHeight [
	^ (layout presenters collect: #preferredHeight) sum
]

{ #category : #private }
RMDSimulationDefinitionPresenter >> theLayout [
	^ layout ifNotNil: [ layout presenters first ]
]
