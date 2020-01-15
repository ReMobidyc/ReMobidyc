Class {
	#name : #RMDUtilityVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUtilityVariableNode class >> agent: aRMDAgentNode identifier: aString [
	^ self new
		agent: aRMDAgentNode;
		identifier: aString;
		yourself
]

{ #category : #testing }
RMDUtilityVariableNode >> isUtilityVariableNode [
	^ true
]

{ #category : #accessing }
RMDUtilityVariableNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDUtilityVariableNode >> printOn: aStream [
	aStream nextPutAll: identifier
]
