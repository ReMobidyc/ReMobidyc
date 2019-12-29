Class {
	#name : #RMDAbstractVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'variable'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #comparing }
RMDAbstractVariableNode >> = anObject [
	^ self class = anObject class and: [ variable = anObject variable ]
]

{ #category : #comparing }
RMDAbstractVariableNode >> hash [
	^ self class hash bitXor: variable hash
]

{ #category : #accessing }
RMDAbstractVariableNode >> operator [
	^ self subclassResponsibility
]

{ #category : #accessing }
RMDAbstractVariableNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDAbstractVariableNode >> printOn: aStream [
	aStream nextPutAll: self operator.
	variable printOn: aStream
]

{ #category : #accessing }
RMDAbstractVariableNode >> symbol [
	^ variable symbol
]

{ #category : #accessing }
RMDAbstractVariableNode >> variable [
	^ variable
]

{ #category : #accessing }
RMDAbstractVariableNode >> variable: aRMDVariableNode [
	variable := aRMDVariableNode
]
