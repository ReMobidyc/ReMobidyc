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

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral [
	^ fromLiteral
]

{ #category : #accessing }
RMDUniformDistributionNode >> fromLiteral: aRMDLiteralNode [
	fromLiteral := aRMDLiteralNode
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
	aStream nextPut: Character space.
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
