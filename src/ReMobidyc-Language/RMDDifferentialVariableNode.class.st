Class {
	#name : #RMDDifferentialVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDifferentialVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter readDifferentialAt: identifier
]

{ #category : #testing }
RMDDifferentialVariableNode >> isDifferentialVariableNode [
	^ true
]

{ #category : #accessing }
RMDDifferentialVariableNode >> operator [
	^ 'd/dt '
]

{ #category : #accessing }
RMDDifferentialVariableNode >> precedence [
	^ 1
]
