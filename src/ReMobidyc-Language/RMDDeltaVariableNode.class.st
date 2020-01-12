Class {
	#name : #RMDDeltaVariableNode,
	#superclass : #RMDAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDeltaVariableNode >> assign: aNumber in: aRMDInterpreter [
	^ aRMDInterpreter
		write: aNumber
		toDelta: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #evaluating }
RMDDeltaVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter
		readDelta: identifier
		agent: agent
		ifAbsent: [ KeyNotFound signal ]
]

{ #category : #testing }
RMDDeltaVariableNode >> isDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDDeltaVariableNode >> operator [
	^ 'Δ'
]
