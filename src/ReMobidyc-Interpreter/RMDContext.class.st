Class {
	#name : #RMDContext,
	#superclass : #Object,
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDContext class >> subject: anInteger definition: aRMDSpeciesDefinitionNode [
	^ self new
		subject: anInteger definition: aRMDSpeciesDefinitionNode;
		yourself
]

{ #category : #'instance creation' }
RMDContext class >> subject: anInteger species: aRMDSpeciesDefinitionNode with: anRMDInterpreter [
	^ self new
		subject: anInteger definition: aRMDSpeciesDefinitionNode;
		setupLocationWith: anRMDInterpreter;
		yourself
]
