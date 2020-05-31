Class {
	#name : #RMDVisualizerPresenter,
	#superclass : #RMDPresenter,
	#instVars : [
		'visualizer',
		'interpreter',
		'image'
	],
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDVisualizerPresenter class >> defaultSpec [
	<spec>
	^ SpPanedLayout newHorizontal
		add: #image;
		add:
			(SpScrollableLayout new
				add:
					(SpBoxLayout newVertical
						spacing: 10;
						beNotHomogeneous;
						add: 'N/A' expand: false;
						yourself);
				yourself);
		yourself
]

{ #category : #'instance creation' }
RMDVisualizerPresenter class >> on: aRMDVisualizer [
	^ self new
		visualizer: aRMDVisualizer;
		yourself
]

{ #category : #'instance creation' }
RMDVisualizerPresenter class >> on: aRMDVisualizer interpreter: aRMDInterpreter [
	^ self new
		visualizer: aRMDVisualizer;
		interpreter: aRMDInterpreter;
		yourself
]

{ #category : #initialization }
RMDVisualizerPresenter >> initializePresenters [
	super initializePresenters.
	image := self newImage
		autoScale: true;
		yourself.
	self whenBuiltDo: [ self updateRendererPresenters ]
]

{ #category : #initialization }
RMDVisualizerPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Visualization settings';
		initialExtent: 600 @ 400
]

{ #category : #accessing }
RMDVisualizerPresenter >> interpreter [
	^ interpreter
]

{ #category : #accessing }
RMDVisualizerPresenter >> interpreter: aRMDInterpreter [
	interpreter ifNotNil: [ interpreter announcer unsubscribe: self ].
	interpreter := aRMDInterpreter.
	interpreter
		ifNotNil: [ interpreter announcer weak
				when: RMDTimeChanged
				send: #updateImage
				to: self ]
]

{ #category : #updating }
RMDVisualizerPresenter >> updateImage [
	interpreter ifNil: [ ^ self ].
	visualizer ifNil: [ ^ self ].
	image
		withWidgetDo: [ :w | 
			visualizer extent: w extent.
			image image: (visualizer visualize: interpreter) ]
]

{ #category : #updating }
RMDVisualizerPresenter >> updateRendererPresenters [
	layout
		ifNotNil: [ | theLayout |
			theLayout := layout presenters second presenters first.
			theLayout removeAll.
			visualizer
				ifNotNil: [ visualizer
						renderersReverseDo: [ :renderer | 
							| presenter |
							presenter := renderer asPresenter.
							presenter whenChangedSend: #updateImage to: self.
							theLayout add: presenter height: presenter preferredHeight ] ] ]
]

{ #category : #accessing }
RMDVisualizerPresenter >> visualizer [
	^ visualizer
]

{ #category : #accessing }
RMDVisualizerPresenter >> visualizer: aRMDVisualizer [
	visualizer := aRMDVisualizer.
	self updateImage.
	self updateRendererPresenters
]
