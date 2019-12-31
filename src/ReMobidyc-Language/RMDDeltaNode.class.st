Class {
	#name : #RMDDeltaNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDDeltaNode >> isDeltaNode [
	^ true
]

{ #category : #accessing }
RMDDeltaNode >> operator [
	^ 'Δ'
]

{ #category : #accessing }
RMDDeltaNode >> precedence [
	^ 1
]
