Class {
	#name : #RMDCellTabularInspector,
	#superclass : #RMDTabularInspector,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #private }
RMDCellTabularInspector >> speciesDefinitionDo: aBlock [
	interpreter ifNotNil: [ aBlock cull: interpreter cellDefinition ]
]
