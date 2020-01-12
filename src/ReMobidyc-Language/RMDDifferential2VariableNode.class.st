Class {
	#name : #RMDDifferential2VariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDifferential2VariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter readDifferential2At: identifier
]

{ #category : #testing }
RMDDifferential2VariableNode >> isDifferential2VariableNode [
	^ true
]

{ #category : #accessing }
RMDDifferential2VariableNode >> operator [
	^ 'd^2/dt^2 '
]

{ #category : #accessing }
RMDDifferential2VariableNode >> precedence [
	^ 1
]
