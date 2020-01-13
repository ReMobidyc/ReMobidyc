Class {
	#name : #RMDDisjunctionNode,
	#superclass : #RMDBinaryCombinatorNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #evaluating }
RMDDisjunctionNode >> evalIn: aRMDInterpreter [
	^ conditions anySatisfy: [ :cond | cond evalIn: aRMDInterpreter ]
]

{ #category : #testing }
RMDDisjunctionNode >> isDisjunctionNode [
	^ true
]

{ #category : #accessing }
RMDDisjunctionNode >> operator [
	^ ' or '
]
