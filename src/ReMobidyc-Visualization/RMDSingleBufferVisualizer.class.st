Class {
	#name : #RMDSingleBufferVisualizer,
	#superclass : #RMDVisualizer,
	#instVars : [
		'form'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDSingleBufferVisualizer class >> exampleSugarSpace [
	<script: 'RMDSingleBufferVisualizer exampleSugarScape'>
	super exampleSugarScape
]

{ #category : #accessing }
RMDSingleBufferVisualizer >> extent: aPoint [
	super extent: aPoint.
	(form isNil or: [ form extent ~= aPoint ])
		ifTrue: [ form := Form extent: aPoint depth: 32 ]
]

{ #category : #private }
RMDSingleBufferVisualizer >> formToWrite [
	^ form
]
