Class {
	#name : #RMDVariableNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'symbol'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDVariableNode class >> symbol: aString [
	^ self new
		symbol: aString;
		yourself
]

{ #category : #printing }
RMDVariableNode >> = anObject [
	^ self class = anObject class and: [ symbol = anObject symbol ]
]

{ #category : #printing }
RMDVariableNode >> hash [
	^ self class bitXor: symbol hash
]

{ #category : #testing }
RMDVariableNode >> isVariableNode [
	^ true
]

{ #category : #accessing }
RMDVariableNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDVariableNode >> printOn: aStream [
	aStream nextPutAll: symbol
]

{ #category : #accessing }
RMDVariableNode >> symbol [
	^ symbol
]

{ #category : #accessing }
RMDVariableNode >> symbol: aString [
	symbol := aString
]
