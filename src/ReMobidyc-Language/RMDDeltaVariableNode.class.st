Class {
	#name : #RMDDeltaVariableNode,
	#superclass : #RMDPropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

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
