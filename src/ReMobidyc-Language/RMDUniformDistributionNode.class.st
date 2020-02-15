Class {
	#name : #RMDUniformDistributionNode,
	#superclass : #RMDRandomNode,
	#instVars : [
		'fromLiteral',
		'toLiteral'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDUniformDistributionNode class >> from: aRMDLiteral to: anotherRMDLiteral [
	^ self new
		fromLiteral: aRMDLiteral;
		toLiteral: anotherRMDLiteral;
		yourself
]

{ #category : #comparing }
RMDUniformDistributionNode >> = anObject [
	^ self class = anObject class
		and: [ fromLiteral = anObject fromLiteral
				and: [ toLiteral = anObject toLiteral ] ]
]

{ #category : #enumerating }
RMDUniformDistributionNode >> childrenDo: aBlock [
	aBlock
		value: fromLiteral;
		value: toLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral [
	^ fromLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral: aRMDLiteralNode [
	fromLiteral := aRMDLiteralNode
]

{ #category : #comparing }
RMDUniformDistributionNode >> hash [
	^ (self class hash bitXor: fromLiteral hash) bitXor: toLiteral hash
]

{ #category : #testing }
RMDUniformDistributionNode >> isUniformDistributionNode [
	^ true
]

{ #category : #accessing }
RMDUniformDistributionNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDUniformDistributionNode >> printOn: aStream [
	aStream nextPutAll: 'uniform '.
	fromLiteral printOn: aStream.
	aStream nextPutAll: ' to '.
	toLiteral printOn: aStream
]

{ #category : #accessing }
RMDUniformDistributionNode >> toLiteral [
	^ toLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> toLiteral: aRMDLiteralNode [
	toLiteral := aRMDLiteralNode
]
