Class {
	#name : #RMDConjunctionNode,
	#superclass : #RMDBinaryCombinatorNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDConjunctionNode >> isConjunctionNode [
	^ true
]

{ #category : #accessing }
RMDConjunctionNode >> operator [
	^ ' and '
]
