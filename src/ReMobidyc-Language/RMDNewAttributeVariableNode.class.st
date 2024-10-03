Class {
	#name : 'RMDNewAttributeVariableNode',
	#superclass : 'RMDAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDNewAttributeVariableNode >> agent [

	^ #new
]

{ #category : 'testing' }
RMDNewAttributeVariableNode >> isNewAttributeVariableNode [
	^ true
]

{ #category : 'accessing' }
RMDNewAttributeVariableNode >> prefix [

	^ 'new'
]
