Class {
	#name : #RMDAssignableDifferentialPropertyVariableNode,
	#superclass : #RMDAbstractAssignablePropertyVariableNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDAssignableDifferentialPropertyVariableNode >> inferType [
	^ self
		unifyType: (propertyVariable inferType ifNotNil: [ :t | t / RMDUnit s ])
]

{ #category : #testing }
RMDAssignableDifferentialPropertyVariableNode >> isAssignableDifferentialPropertyVariableNode [
	^ true
]

{ #category : #accessing }
RMDAssignableDifferentialPropertyVariableNode >> operator [
	^ 'd/dt '
]
