Class {
	#name : 'RMDSpeciesError',
	#superclass : 'RMDRuntimeError',
	#instVars : [
		'animatDefinition1',
		'animatDefinition2'
	],
	#category : 'ReMobidyc-Interpreter-Exceptions',
	#package : 'ReMobidyc-Interpreter',
	#tag : 'Exceptions'
}

{ #category : 'instance creation' }
RMDSpeciesError class >> on: aRMDSyntaxNode animatDefinition1: aRMDAnimatDefintionNode animatDefinition2: anotherRMDAnimatDefinitionNode [

	^ (self on: aRMDSyntaxNode)
		  animatDefinition1: aRMDAnimatDefintionNode;
		  animatDefinition2: anotherRMDAnimatDefinitionNode;
		  yourself
]

{ #category : 'accessing' }
RMDSpeciesError >> animatDefinition1 [

	^ animatDefinition1
]

{ #category : 'accessing' }
RMDSpeciesError >> animatDefinition1: aRMDAnimatDefinitionNode [

	animatDefinition1 := aRMDAnimatDefinitionNode
]

{ #category : 'accessing' }
RMDSpeciesError >> animatDefinition2 [

	^ animatDefinition2
]

{ #category : 'accessing' }
RMDSpeciesError >> animatDefinition2: aRMDAnimatDefinitionNode [

	animatDefinition2 := aRMDAnimatDefinitionNode
]

{ #category : 'private' }
RMDSpeciesError >> composeMessageText [

	^ String streamContents: [ :stream | 
		  stream
			  nextPutAll: 'Species mismatch error: ';
			  nextPutAll: animatDefinition1 identifier;
			  nextPutAll: ' (';
			  nextPutAll: animatDefinition1 species;
			  nextPutAll: ') and ';
			  nextPutAll: animatDefinition2 identifier;
			  nextPutAll: ' (';
			  nextPutAll: animatDefinition2 species;
			  nextPutAll: ')' ]
]
