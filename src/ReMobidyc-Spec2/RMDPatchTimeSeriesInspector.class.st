Class {
	#name : #RMDPatchTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #enumerating }
RMDPatchTimeSeriesInspector >> speciesDefinitionDo: aBlock [

	aBlock cull: interpreter patchDefinition
]
