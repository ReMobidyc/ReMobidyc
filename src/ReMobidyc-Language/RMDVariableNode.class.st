Class {
	#name : #RMDVariableNode,
	#superclass : #RMDAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #evaluating }
RMDVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readVariable: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #testing }
RMDVariableNode >> isVariableNode [
	^ true
]

{ #category : #accessing }
RMDVariableNode >> operator [
	^ ''
]
