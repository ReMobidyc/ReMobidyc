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
		ifNotNil: [ layout presenters first
				removeAll;
				add: node timeDefinition asPresenter
					height: self class inputTextHeight + 5;
				add: node worldInitializer asPresenter
					height:
					self class inputTextHeight
						* (node worldInitializer propertyInitializers size + 1) + 5;
				add: node cellInitializer asPresenter
					height:
					self class inputTextHeight
						* (node cellInitializer propertyInitializers size + 1) + 5.
			node animatInitializers
				do: [ :initializer | 
					layout presenters first
						add: initializer asPresenter
						height:
							self class inputTextHeight
								* (initializer propertyInitializers size + 1) + 5 ] ]
]
