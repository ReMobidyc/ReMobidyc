Class {
	#name : #RMDDifferentialNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDDifferentialNode class >> variable: aRMDVariableNode [
	^ self new
		variable: aRMDVariableNode;
		yourself
]

{ #category : #testing }
RMDDifferentialNode >> isDifferentialNode [
	^ true
]

{ #category : #printing }
RMDDifferentialNode >> operator [
	^ 'd/dt '
]
