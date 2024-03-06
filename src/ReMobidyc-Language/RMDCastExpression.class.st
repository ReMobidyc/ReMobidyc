Class {
	#name : #RMDCastExpression,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'unit',
		'expression'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDCastExpression class >> expression: aRMDExpressionNode unit: aRMDUnit [

	^ self new
		  expression: aRMDExpressionNode;
		  unit: aRMDUnit;
		  yourself
]

{ #category : #testing }
RMDCastExpression class >> isAbstract [

	^ self == RMDCastExpression
]

{ #category : #comparing }
RMDCastExpression >> = anObject [

	^ self class = anObject class and: [ 
		  expression = anObject expression and: [ unit = anObject unit ] ]
]

{ #category : #enumerating }
RMDCastExpression >> childrenDo: aBlock [

	aBlock value: expression
]

{ #category : #enumerating }
RMDCastExpression >> childrenTransform: aBlock [

	expression := aBlock value: expression
]

{ #category : #accessing }
RMDCastExpression >> expression [

	^ expression
]

{ #category : #accessing }
RMDCastExpression >> expression: aRMDExpressionNode [

	expression := aRMDExpressionNode
]

{ #category : #comparing }
RMDCastExpression >> hash [

	^ (self class hash bitXor: expression hash) bitXor: unit hash
]

{ #category : #copying }
RMDCastExpression >> postCopy [

	expression := expression copy
]

{ #category : #rewriting }
RMDCastExpression >> replaceChildren: aDictionary [

	expression := expression copyReplace: aDictionary.
	aDictionary at: unit ifPresent: [ :node | unit := node copy ]
]

{ #category : #accessing }
RMDCastExpression >> unit [

	^ unit
]

{ #category : #accessing }
RMDCastExpression >> unit: aRMDUnit [

	unit := aRMDUnit
]
