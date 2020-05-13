Class {
	#name : #RMDVisualizerEditor,
	#superclass : #RMDPresenter,
	#instVars : [
		'visualizer'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDVisualizerEditor class >> defaultSpec [
	<spec>
	^ SpScrollableLayout new
		add:
			(SpBoxLayout newVertical
				spacing: 10;
				beNotHomogeneous;
				add: 'N/A' expand: false;
				yourself);
		yourself
]

{ #category : #'instance creation' }
RMDVisualizerEditor class >> on: aRMDVisualizer [
	^ self new
		visualizer: aRMDVisualizer;
		yourself
]

{ #category : #initialization }
RMDVisualizerEditor >> initializeWidgets [
	super initializeWidgets.
	self whenBuiltDo: [ self updateRendererEditors ]
]

{ #category : #initialization }
RMDVisualizerEditor >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Visualization settings';
		initialExtent: 600 @ 400
]

{ #category : #updating }
RMDVisualizerEditor >> updateRendererEditors [
	layout
		ifNotNil: [ | theLayout |
			theLayout := layout presenters first.
			theLayout removeAll.
			visualizer
				ifNotNil: [ visualizer
						renderersDo: [ :renderer | 
							| presenter |
							presenter := renderer asPresenter.
							theLayout add: presenter height: presenter preferredHeight ] ] ]
]

{ #category : #accessing }
RMDVisualizerEditor >> visualizer [
	^ visualizer
]

{ #category : #accessing }
RMDVisualizerEditor >> visualizer: aRMDVisualizer [
	visualizer := aRMDVisualizer.
	self updateRendererEditors
]
