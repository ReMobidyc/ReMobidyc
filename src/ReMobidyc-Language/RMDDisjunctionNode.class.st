Class {
	#name : #RMDDisjunctionNode,
	#superclass : #RMDBinaryCombinatorNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDDisjunctionNode >> isDisjunctionNode [
	^ true
]

{ #category : #accessing }
RMDDisjunctionNode >> operator [
	^ ' or '
]
