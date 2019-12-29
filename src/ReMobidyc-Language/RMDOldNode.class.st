Class {
	#name : #RMDOldNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'variable'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDOldNode class >> variable: aRMDVariableNode [
	^ self new
		variable: aRMDVariableNode;
		yourself
]

{ #category : #testing }
RMDOldNode >> isOldNode [
	^ true
]

{ #category : #accessing }
RMDOldNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDOldNode >> printOn: aStream [
	aStream nextPutAll: 'old '.
	variable printOn: aStream
]

{ #category : #accessing }
RMDOldNode >> symbol [
	^ variable symbol
]

{ #category : #accessing }
RMDOldNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDOldNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
