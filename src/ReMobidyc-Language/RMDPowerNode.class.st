Class {
	#name : #RMDPowerNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'expression',
		'order'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDPowerNode class >> expression: aRMDExpression order: anInteger [
	^ self new
		expression: aRMDExpression;
		order: anInteger;
		yourself
]

{ #category : #comparing }
RMDPowerNode >> = anObject [
	^ self class = anObject class
		and: [ expression = anObject expression
				and: [ order = anObject order ] ]
]

{ #category : #enumerating }
RMDPowerNode >> childrenDo: aBlock [
	aBlock value: expression
]

{ #category : #accessing }
RMDPowerNode >> expression [
	^ expression
]

{ #category : #accessing }
RMDPowerNode >> expression: aRMDExpressionNode [
	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDPowerNode >> hash [
	^ self class hash bitXor: (expression hash bitXor: order hash)
]

{ #category : #testing }
RMDPowerNode >> isPowerNode [
	^ true
]

{ #category : #accessing }
RMDPowerNode >> operator [
	^ '^'
]

{ #category : #accessing }
RMDPowerNode >> order [
	^ order
]

{ #category : #accessing }
RMDPowerNode >> order: anInteger [
	order := anInteger
]

{ #category : #copying }
RMDPowerNode >> postCopy [
	expression := expression copy
]

{ #category : #accessing }
RMDPowerNode >> precedence [
	^ 2
]

{ #category : #printing }
RMDPowerNode >> printOn: aStream [
	expression printOn: aStream.
	aStream nextPutAll: self operator.
	order printOn: aStream
]

{ #category : #rewriting }
RMDPowerNode >> replaceChildren: aDictionary [
	expression := expression copyReplace: aDictionary
]
