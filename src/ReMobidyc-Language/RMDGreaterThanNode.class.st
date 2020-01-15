Class {
	#name : #RMDGreaterThanNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDGreaterThanNode >> isGreaterThanNode [
	^ true
]

{ #category : #accessing }
RMDGreaterThanNode >> operator [
	^ ' > '
]
