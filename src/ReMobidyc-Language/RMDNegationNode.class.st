Class {
	#name : #RMDNegationNode,
	#superclass : #RMDConditionNode,
	#instVars : [
		'condition'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDNegationNode class >> condition: aRMDConditionNode [
	^ self new
		condition: aRMDConditionNode;
		yourself
]

{ #category : #comparing }
RMDNegationNode >> = anObject [
	^ self class = anObject class and: [ condition = anObject condition ]
]

{ #category : #enumerating }
RMDNegationNode >> childrenDo: aBlock [
	aBlock value: condition
]

{ #category : #accessing }
RMDNegationNode >> condition [
	^ condition
]

{ #category : #accessing }
RMDNegationNode >> condition: aRMDConditionNode [
	condition := aRMDConditionNode
]

{ #category : #comparing }
RMDNegationNode >> hash [
	^ self class hash bitXor: condition hash
]

{ #category : #testing }
RMDNegationNode >> isNegationNode [
	^ true
]

{ #category : #accessing }
RMDNegationNode >> precedence [
	^ 1
]

{ #category : #printing }
RMDNegationNode >> printOn: aStream [
	aStream nextPutAll: 'not '.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $( ].
	condition printOn: aStream.
	self precedence <= condition precedence
		ifFalse: [ aStream nextPut: $) ]
]
