Class {
	#name : #RMDInitializerContext,
	#superclass : #RMDContext,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDInitializerContext class >> subject: anInteger species: aRMDSpeciesDefinitionNode [
	^ self new
		subject: anInteger species: aRMDSpeciesDefinitionNode;
		yourself
]

{ #category : #accessing }
RMDInitializerContext >> subject: anInteger species: aRMDSpeciesDefinitionNode [
	| dict |
	super subject: anInteger species: aRMDSpeciesDefinitionNode.
	subjectSpecies := aRMDSpeciesDefinitionNode.
	dict := Dictionary new.
	aRMDSpeciesDefinitionNode
		propertyOffsetsDo: [ :identifier :offset | dict at: identifier put: anInteger + offset ].
	propertyDict := Dictionary new
		at: nil put: dict;
		yourself
]
