Class {
	#name : #RMDPatchTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #enumerating }
RMDPatchTimeSeriesInspector >> agentDefinitionDo: aBlock [

	aBlock cull: interpreter patchDefinition
]
