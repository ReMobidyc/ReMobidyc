Class {
	#name : 'RMDOSWindowPresenter',
	#superclass : 'Object',
	#instVars : [
		'widget'
	],
	#category : 'ReMobidyc-Spec2-Utilities',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Utilities'
}

{ #category : 'instance creation' }
RMDOSWindowPresenter class >> on: anOSWindowWorldMorph [

	^ self new
		  widget: anOSWindowWorldMorph;
		  yourself
]

{ #category : 'accessing' }
RMDOSWindowPresenter >> initialExtent: aPoint [

	aPoint ifNotNil: [
		widget worldState worldRenderer osWindow extent: aPoint ]
]

{ #category : 'accessing' }
RMDOSWindowPresenter >> title: aString [

	aString ifNotNil: [
		widget worldState worldRenderer windowTitle: aString ]
]

{ #category : 'accessing' }
RMDOSWindowPresenter >> widget [

	^ widget
]

{ #category : 'accessing' }
RMDOSWindowPresenter >> widget: anOSWindowWorldMorph [

	widget := anOSWindowWorldMorph
]

{ #category : 'accessing' }
RMDOSWindowPresenter >> windowIcon: aForm [

	widget worldState worldRenderer icon: aForm
]
