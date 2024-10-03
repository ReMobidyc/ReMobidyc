Class {
	#name : 'RMDVisualizationFileNode',
	#superclass : 'RMDModelFileNode',
	#instVars : [
		'renderers'
	],
	#category : 'ReMobidyc-Language-File',
	#package : 'ReMobidyc-Language',
	#tag : 'File'
}

{ #category : 'instance creation' }
RMDVisualizationFileNode class >> renderers: anArrayOfRMDRenderer [

	^ self new
		  renderers: anArrayOfRMDRenderer;
		  yourself
]

{ #category : 'enumerating' }
RMDVisualizationFileNode >> contentsDo: aBlock [

	renderers do: aBlock
]

{ #category : 'testing' }
RMDVisualizationFileNode >> isVisualizationFileNode [

	^ true
]

{ #category : 'accessing' }
RMDVisualizationFileNode >> renderers [

	^ renderers
]

{ #category : 'accessing' }
RMDVisualizationFileNode >> renderers: anArrayOfRMDRenderer [

	renderers := anArrayOfRMDRenderer
]
