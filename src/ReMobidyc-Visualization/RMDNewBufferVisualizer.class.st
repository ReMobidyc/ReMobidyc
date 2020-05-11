Class {
	#name : #RMDNewBufferVisualizer,
	#superclass : #RMDVisualizer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #examples }
RMDNewBufferVisualizer class >> exampleSugarSpace [
	<script: 'RMDNewBufferVisualizer exampleSugarScape'>
	super exampleSugarScape
]

{ #category : #private }
RMDNewBufferVisualizer >> formToWrite [
	^ Form extent: extent depth: 32
]
