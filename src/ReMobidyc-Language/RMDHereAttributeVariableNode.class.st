Class {
	#name : #RMDHereAttributeVariableNode,
	#superclass : #RMDAttributeVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDHereAttributeVariableNode >> agent [
	^ #here
]

{ #category : #testing }
RMDHereAttributeVariableNode >> isHereAttributeVariableNode [

	^ true
]

{ #category : #accessing }
RMDHereAttributeVariableNode >> prefix [

	^ 'here''s'
]
