Class {
	#name : #RMDConjunctionNode,
	#superclass : #RMDBinaryCombinatorNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDConjunctionNode >> evalIn: aRMDInterpreter [
	^ conditions allSatisfy: [ :cond | cond evalIn: aRMDInterpreter ]
]

{ #category : #testing }
RMDConjunctionNode >> isConjunctionNode [
	^ true
]

{ #category : #accessing }
RMDConjunctionNode >> operator [
	^ ' and '
]
