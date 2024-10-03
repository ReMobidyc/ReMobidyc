Class {
	#name : 'RMDAssignableDifferentialAttributeVariableNode',
	#superclass : 'RMDAbstractAssignableAttributeVariableNode',
	#category : 'ReMobidyc-Language-AST',
	#package : 'ReMobidyc-Language',
	#tag : 'AST'
}

{ #category : 'testing' }
RMDAssignableDifferentialAttributeVariableNode >> isAssignableDifferentialAttributeVariableNode [
	^ true
]

{ #category : 'accessing' }
RMDAssignableDifferentialAttributeVariableNode >> operator [
	^ 'd/dt '
]
