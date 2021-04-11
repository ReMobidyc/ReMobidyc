Class {
	#name : #RMDAssignablePropertyVariableNode,
	#superclass : #RMDAbstractAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDAssignablePropertyVariableNode >> inferType [
	^ self unifyType: propertyVariable inferType
]

{ #category : #testing }
RMDAssignablePropertyVariableNode >> isAssignablePropertyVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignablePropertyVariableNode >> operator [
	^ ''
]
