Class {
	#name : #RMDPopulationTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#instVars : [
		'animatDefinition'
	],
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #accessing }
RMDPopulationTimeSeriesInspector >> animatDefinition [

	^ animatDefinition
]

{ #category : #accessing }
RMDPopulationTimeSeriesInspector >> animatDefinition: aRMDAnimatDefinitionNode [
	animatDefinition := aRMDAnimatDefinitionNode .
	self updateTitleLabel
]

{ #category : #evaluating }
RMDPopulationTimeSeriesInspector >> eval [

	^ interpreter numberOfIndivisualsOf: animatDefinition
]

{ #category : #accessing }
RMDPopulationTimeSeriesInspector >> updateTitleLabel [

	titleLabel ifNotNil: [ 
		titleLabel label: 'Population of '
			, (animatDefinition ifNotNil: #identifier ifNil: [ '-' ]) ]
]
