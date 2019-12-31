Class {
	#name : #RMDOldNode,
	#superclass : #RMDAbstractVariableNode,
	#category : #'ReMobidyc-Language'
}

{ #category : #testing }
RMDOldNode >> isOldNode [
	^ true
]

{ #category : #printing }
RMDOldNode >> operator [
	^ 'old '
]

{ #category : #accessing }
RMDOldNode >> precedence [
	^ 1
]
