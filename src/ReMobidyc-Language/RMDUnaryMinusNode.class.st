Class {
	#name : #RMDUnaryMinusNode,
	#superclass : #RMDUnaryOperatorApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #testing }
RMDUnaryMinusNode >> isUnaryMinusNode [
	^ true
]

{ #category : #accessing }
RMDUnaryMinusNode >> precedence [
	^ 1
]
