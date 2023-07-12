Class {
	#name : #RMDResidualNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDResidualNode >> isResidualNode [

	^ true
]

{ #category : #accessing }
RMDResidualNode >> operator [
	^ '%'
]

{ #category : #accessing }
RMDResidualNode >> precedence [
	^ 4
]
