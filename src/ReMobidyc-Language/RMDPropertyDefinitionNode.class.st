Class {
	#name : #RMDPropertyDefinitionNode,
	#superclass : #RMDDefinitionNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDPropertyDefinitionNode >> evalIn: aRMDInterpreter [
	^ variable
		assign: (definitionBody evalIn: aRMDInterpreter)
		in: aRMDInterpreter
]

{ #category : #testing }
RMDPropertyDefinitionNode >> isPropertyDefinitionNode [
	^ true
]

{ #category : #accessing }
RMDPropertyDefinitionNode >> operator [
	^ '='
]
