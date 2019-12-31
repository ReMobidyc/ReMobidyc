Class {
	#name : #RMDDifferentialNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDDifferentialNode >> isDifferentialNode [
	^ true
]

{ #category : #printing }
RMDDifferentialNode >> operator [
	^ 'd/dt '
]

{ #category : #accessing }
RMDDifferentialNode >> precedence [
	^ 1
]
