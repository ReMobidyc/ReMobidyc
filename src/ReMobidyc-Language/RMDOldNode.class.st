Class {
	#name : #RMDOldNode,
	#superclass : #RMDAbstractVariableNode,
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

{ #category : #printing }
RMDOldNode >> operator [
	^ 'old '
]
