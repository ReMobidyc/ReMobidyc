Class {
	#name : #RMDSimulationDefinitionEditor,
	#superclass : #RMDSyntaxNodeEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDSimulationDefinitionEditor class >> defaultSpec [
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
RMDSimulationDefinitionEditor >> add: aRMDSyntaxNodeEditor [
	self theLayout
		add: aRMDSyntaxNodeEditor
		height: aRMDSyntaxNodeEditor preferredHeight
]

{ #category : #initialization }
RMDSimulationDefinitionEditor >> initializePresenters [
	self nodeChanged
]

{ #category : #initialization }
RMDSimulationDefinitionEditor >> initializeWidgets [
	super initializeWidgets.
	self whenBuiltDo: [ self nodeChanged ]
]

{ #category : #initialization }
RMDSimulationDefinitionEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Simulation Definition';
		initialExtent: 600 @ 400
]

{ #category : #accessing }
RMDSimulationDefinitionEditor >> nodeChanged [
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
RMDSimulationDefinitionEditor >> preferredHeight [
	^ (layout presenters collect: #preferredHeight) sum
]

{ #category : #private }
RMDSimulationDefinitionEditor >> theLayout [
	^ layout ifNotNil: [ layout presenters first ]
]
