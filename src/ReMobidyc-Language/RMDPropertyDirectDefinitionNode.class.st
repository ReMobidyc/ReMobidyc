Class {
	#name : #RMDPropertyDirectDefinitionNode,
	#superclass : #RMDPropertyDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDPropertyDirectDefinitionNode >> isPropertyDirectDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyDirectDefinitionNode >> operator [
	^ '='
]
