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
				borderWidth: 20;
				spacing: 10;
				add: 'N/A' expand: false;
				yourself);
		yourself
]

{ #category : #initialization }
RMDSimulationDefinitionEditor >> initializePresenters [
	self nodeChanged
]

{ #category : #initialization }
RMDSimulationDefinitionEditor >> initializeWidgets [
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
		ifNotNil: [ layout presenters first
				removeAll;
				add: node timeDefinition asPresenter
					height: self class inputTextHeight + 10;
				add: node worldInitializer asPresenter
					height:
					(self class inputTextHeight + 10)
						* (node worldInitializer propertyInitializers size + 1);
				add: node cellInitializer asPresenter
					height:
					(self class inputTextHeight + 10)
						* (node cellInitializer propertyInitializers size + 1).
			node animatInitializers
				do: [ :initializer | 
					layout presenters first
						add: initializer asPresenter
						height:
							(self class inputTextHeight + 10)
								* (initializer propertyInitializers size + 1) ] ]
]
