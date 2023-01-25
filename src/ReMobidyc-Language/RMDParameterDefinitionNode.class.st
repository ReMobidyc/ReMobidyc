Class {
	#name : #RMDParameterDefinitionNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'parameterSetSequences'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDParameterDefinitionNode >> parameterSetSequences [

	^ parameterSetSequences
]

{ #category : #accessing }
RMDParameterDefinitionNode >> parameterSetSequences: anArrayOfRMDParameterSequenceNode [

	parameterSetSequences := anArrayOfRMDParameterSequenceNode
]
