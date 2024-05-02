Class {
	#name : 'RMDRendererPresenter',
	#superclass : 'RMDPresenter',
	#instVars : [
		'renderer',
		'colorDropList',
		'agentFieldEnabled'
	],
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'testing' }
RMDRendererPresenter class >> isAbstract [

	^ self == RMDRendererPresenter
]

{ #category : 'instance creation' }
RMDRendererPresenter class >> on: aRMDRenderer [
	^ self new
		renderer: aRMDRenderer;
		yourself
]

{ #category : 'accessing' }
RMDRendererPresenter >> disableAgentFields [

	agentFieldEnabled := false
]

{ #category : 'accessing' }
RMDRendererPresenter >> enableAgentFields [
	agentFieldEnabled := true
]

{ #category : 'initialization' }
RMDRendererPresenter >> initialize [
	super initialize.
	agentFieldEnabled := true
]

{ #category : 'initialization' }
RMDRendererPresenter >> initializePresenters [

	super initializePresenters.
	colorDropList := self newColorDropList
		                 whenSelectedItemChangedDo: [ :color | 
			                 color ifNotNil: [ 
					                 renderer color: color.
					                 self valueChanged ] ];
		                 yourself
]

{ #category : 'accessing' }
RMDRendererPresenter >> name [
	^ renderer name
]

{ #category : 'accessing' }
RMDRendererPresenter >> renderer [
	^ renderer
]

{ #category : 'accessing' }
RMDRendererPresenter >> renderer: aRMDRenderer [
	renderer := aRMDRenderer.
	self rendererChanged
]

{ #category : 'accessing' }
RMDRendererPresenter >> rendererChanged [
	self updateColorDropList
]

{ #category : 'accessing' }
RMDRendererPresenter >> simulationModel: aRMDSimulationModel [
]

{ #category : 'updating' }
RMDRendererPresenter >> updateColorDropList [
	renderer
		ifNotNil: [ | color colors |
			color := renderer color.
			colors := colorDropList listItems.
			(colors includes: color)
				ifFalse: [ colorDropList items: (colors copyWith: color) ].
			colorDropList selectItem: renderer color ]
]
