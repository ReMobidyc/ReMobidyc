Class {
	#name : #RMDVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDVariableNode class >> symbol: aString [
	^ self new
		symbol: aString;
		yourself
]

{ #category : #testing }
RMDVariableNode >> isVariableNode [
	^ true
]

{ #category : #accessing }
RMDVariableNode >> operator [
	^ ''
]

{ #category : #accessing }
RMDVariableNode >> precedence [
	^ 0
]
