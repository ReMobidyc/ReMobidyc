Class {
	#name : #RMDDeltaNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDDeltaNode class >> variable: aRMDVariableNode [
	^ self new
		variable: aRMDVariableNode;
		yourself
]

{ #category : #testing }
RMDDeltaNode >> isDeltaNode [
	^ true
]

{ #category : #accessing }
RMDDeltaNode >> operator [
	^ 'Δ'
]
