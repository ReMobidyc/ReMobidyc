Class {
	#name : #RMDUtilityDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDUtilityDefinitionNode >> isUtilityDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDUtilityDefinitionNode >> operator [
	^ '='
]
