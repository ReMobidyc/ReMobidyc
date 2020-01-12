Class {
	#name : #RMDDifferentialVariableNode,
	#superclass : #RMDPropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDifferentialVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readDifferential: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #testing }
RMDDifferentialVariableNode >> isDifferentialVariableNode [
	^ true
]

{ #category : #accessing }
RMDDifferentialVariableNode >> operator [
	^ 'd/dt '
]
