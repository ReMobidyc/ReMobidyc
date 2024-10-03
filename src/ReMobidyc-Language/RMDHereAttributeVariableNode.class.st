Class {
	#name : 'RMDHereAttributeVariableNode',
	#superclass : 'RMDAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDHereAttributeVariableNode >> agent [
	^ #here
]

{ #category : 'testing' }
RMDHereAttributeVariableNode >> isHereAttributeVariableNode [

	^ true
]

{ #category : 'accessing' }
RMDHereAttributeVariableNode >> prefix [

	^ 'here''s'
]
