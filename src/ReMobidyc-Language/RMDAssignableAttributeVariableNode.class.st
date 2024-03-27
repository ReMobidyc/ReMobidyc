Class {
	#name : #RMDAssignableAttributeVariableNode,
	#superclass : #RMDAbstractAssignableAttributeVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #accessing }
RMDAssignableAttributeVariableNode >> identifier: aString [

	self attributeVariable identifier: aString
]

{ #category : #testing }
RMDAssignableAttributeVariableNode >> isAssignableAttributeVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableAttributeVariableNode >> operator [
	^ ''
]
