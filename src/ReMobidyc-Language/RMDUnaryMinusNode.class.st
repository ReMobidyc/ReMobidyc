Class {
	#name : #RMDUnaryMinusNode,
	#superclass : #RMDUnaryOperatorApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDUnaryMinusNode >> inferType [
	self unifyType: expression inferType.
	^ type
]

{ #category : #testing }
RMDUnaryMinusNode >> isUnaryMinusNode [
	^ true
]

{ #category : #accessing }
RMDUnaryMinusNode >> operator [
	^ '-'
]

{ #category : #accessing }
RMDUnaryMinusNode >> precedence [
	^ 1
]
