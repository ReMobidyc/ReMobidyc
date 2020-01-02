Class {
	#name : #RMDScriptNode,
	#superclass : #RMDSyntaxNode,
	#instVars : [
		'identifier',
		'propertyDefinitions',
		'utilityDefinitions'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDScriptNode >> identifier [
	^ identifier
]

{ #category : #accessing }
RMDScriptNode >> identifier: aString [
	identifier := aString
]

{ #category : #accessing }
RMDScriptNode >> propertyDefinitions [
	^ propertyDefinitions
]

{ #category : #accessing }
RMDScriptNode >> propertyDefinitions: aRMDPropertyDefinitionNode [
	propertyDefinitions := aRMDPropertyDefinitionNode
]

{ #category : #accessing }
RMDScriptNode >> utilityDefinitions [
	^ utilityDefinitions
]

{ #category : #accessing }
RMDScriptNode >> utilityDefinitions: anObject [
	utilityDefinitions := anObject
]
