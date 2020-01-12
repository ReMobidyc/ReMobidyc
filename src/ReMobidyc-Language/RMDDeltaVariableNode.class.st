Class {
	#name : #RMDDeltaVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDeltaVariableNode >> evalIn: aRMDInterpreter [
	^ aRMDInterpreter readDeltaAt: identifier
]

{ #category : #testing }
RMDDeltaVariableNode >> isDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDDeltaVariableNode >> operator [
	^ 'Δ'
]

{ #category : #accessing }
RMDDeltaVariableNode >> precedence [
	^ 1
]
