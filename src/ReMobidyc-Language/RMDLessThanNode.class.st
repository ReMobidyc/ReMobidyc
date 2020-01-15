Class {
	#name : #RMDLessThanNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDLessThanNode >> isLessThanNode [
	^ true
]

{ #category : #accessing }
RMDLessThanNode >> operator [
	^ ' < '
]
