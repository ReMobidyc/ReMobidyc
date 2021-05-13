Class {
	#name : #RMDWorldTabularInspector,
	#superclass : #RMDTabularInspector,
	#category : #'ReMobidyc-Spec2-Browsers'
}

{ #category : #private }
RMDWorldTabularInspector >> speciesDefinitionDo: aBlock [
	interpreter ifNotNil: [ aBlock cull: interpreter worldDefinition ]
]
