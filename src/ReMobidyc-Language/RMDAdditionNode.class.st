Class {
	#name : #RMDAdditionNode,
	#superclass : #RMDLeftAssociativeApplicationNode,
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'type checking' }
RMDAdditionNode >> inferType [
	self
		unifyType: expression1 inferType;
		unifyType: expression2 inferType.
	^ type
]

{ #category : #testing }
RMDAdditionNode >> isAdditionNode [
	^ true
]

{ #category : #accessing }
RMDAdditionNode >> operator [
	^ '+'
]

{ #category : #accessing }
RMDAdditionNode >> precedence [
	^ 5
]
