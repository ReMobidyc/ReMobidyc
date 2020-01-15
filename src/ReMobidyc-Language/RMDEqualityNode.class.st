Class {
	#name : #RMDEqualityNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDEqualityNode >> isEqualityNode [
	^ true
]

{ #category : #accessing }
RMDEqualityNode >> operator [
	^ ' = '
]
