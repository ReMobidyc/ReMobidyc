Class {
	#name : #RMDDoubleBufferVisualizer,
	#superclass : #RMDVisualizer,
	#instVars : [
		'formToWrite',
		'formToRead'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDDoubleBufferVisualizer class >> exampleSugarSpace [
	<script: 'RMDDoubleBufferVisualizer exampleSugarScape'>
	super exampleSugarScape
]

{ #category : #accessing }
RMDDoubleBufferVisualizer >> extent: aPoint [
	super extent: aPoint.
	(formToRead isNil or: [ formToRead extent ~= aPoint ])
		ifTrue: [ formToRead := Form extent: aPoint depth: 32 ].
	(formToWrite isNil or: [ formToWrite extent ~= aPoint ])
		ifTrue: [ formToWrite := Form extent: aPoint depth: 32 ]
]

{ #category : #private }
RMDDoubleBufferVisualizer >> formToWrite [
	^ formToWrite
]

{ #category : #visualizing }
RMDDoubleBufferVisualizer >> visualize: aRMDInterpreter [
	| form |
	super visualize: aRMDInterpreter.
	form := formToRead.
	formToRead := formToWrite.
	formToWrite := form.
	^ formToRead
]
