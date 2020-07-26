Class {
	#name : #RMDUtilityVariableNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUtilityVariableNode class >> identifier: aString [
	^ self new
		identifier: aString;
		yourself
]

{ #category : #enumerating }
RMDUtilityVariableNode >> childrenDo: aBlock [

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
