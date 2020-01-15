Class {
	#name : #RMDGreaterOrEqualNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDGreaterOrEqualNode >> isGreaterOrEqualNode [ 
	^ true
]

{ #category : #accessing }
RMDGreaterOrEqualNode >> operator [
	^ ' >= '
]
