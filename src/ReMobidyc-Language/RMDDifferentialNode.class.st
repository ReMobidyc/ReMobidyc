Class {
	#name : #RMDDifferentialNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'variable'
	],
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

{ #category : #accessing }
RMDDifferentialNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDDifferentialNode >> printOn: aStream [
	aStream nextPutAll: 'd/dt '.
	variable printOn: aStream
]

{ #category : #accessing }
RMDDifferentialNode >> symbol [
	^ variable symbol
]

{ #category : #accessing }
RMDDifferentialNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDDifferentialNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
