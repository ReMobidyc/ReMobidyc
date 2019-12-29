Class {
	#name : #RMDDeltaNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'variable'
	],
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
RMDDeltaNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDDeltaNode >> printOn: aStream [
	aStream nextPutAll: 'Δ'.
	variable printOn: aStream
]

{ #category : #accessing }
RMDDeltaNode >> symbol [
	^ variable symbol
]

{ #category : #accessing }
RMDDeltaNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDDeltaNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
