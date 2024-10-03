Class {
	#name : 'RMDAssignableAttributeVariableNode',
	#superclass : 'RMDAbstractAssignableAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'accessing' }
RMDAssignableAttributeVariableNode >> identifier: aString [

	self attributeVariable identifier: aString
]

{ #category : 'testing' }
RMDAssignableAttributeVariableNode >> isAssignableAttributeVariableNode [
	^ true
]

{ #category : 'accessing' }
RMDAssignableAttributeVariableNode >> operator [
	^ ''
]
