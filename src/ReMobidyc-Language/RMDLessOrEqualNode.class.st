Class {
	#name : #RMDLessOrEqualNode,
	#superclass : #RMDBinaryRelationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDLessOrEqualNode >> isLessOrEqualNode [
	^ true
]

{ #category : #accessing }
RMDLessOrEqualNode >> operator [
	^ ' <= '
]
