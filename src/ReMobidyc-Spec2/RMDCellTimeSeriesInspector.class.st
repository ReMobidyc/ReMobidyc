Class {
	#name : #RMDCellTimeSeriesInspector,
	#superclass : #RMDTimeSeriesInspector,
	#category : #'ReMobidyc-Spec2-Inspectors'
}

{ #category : #enumerating }
RMDCellTimeSeriesInspector >> speciesDefinitionDo: aBlock [

	aBlock cull: interpreter cellDefinition
]
