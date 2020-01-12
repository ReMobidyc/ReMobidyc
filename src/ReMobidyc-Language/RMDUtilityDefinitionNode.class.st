Class {
	#name : #RMDUtilityDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDUtilityDefinitionNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		write: (definitionBody evalIn: aRMDInterpreter)
		toUtility: variable identifier
]

{ #category : #testing }
RMDUtilityDefinitionNode >> isUtilityDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDUtilityDefinitionNode >> operator [
	^ '='
]
