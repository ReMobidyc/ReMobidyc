Class {
	#name : #RMDDifferential2Node,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'variable'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDDifferential2Node class >> variable: aRMDVariableNode [
	^ self new
		variable: aRMDVariableNode;
		yourself
]

{ #category : #testing }
RMDDifferential2Node >> isDifferential2Node [
	^ true
]

{ #category : #accessing }
RMDDifferential2Node >> precedence [
	^ 1
]

{ #category : #printing }
RMDDifferential2Node >> printOn: aStream [
	aStream nextPutAll: 'd^2/dt^2 '.
	variable printOn: aStream
]

{ #category : #accessing }
RMDDifferential2Node >> symbol [
	^ variable symbol
]

{ #category : #accessing }
RMDDifferential2Node >> variable [
	^ variable
]

{ #category : #accessing }
RMDDifferential2Node >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
