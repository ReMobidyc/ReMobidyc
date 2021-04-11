Class {
	#name : #RMDAssignableDeltaPropertyVariableNode,
	#superclass : #RMDAbstractAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDAssignableDeltaPropertyVariableNode >> inferType [
	^ self unifyType: propertyVariable inferType
]

{ #category : #testing }
RMDAssignableDeltaPropertyVariableNode >> isAssignableDeltaVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDeltaPropertyVariableNode >> operator [
	^ 'Δ'
]
