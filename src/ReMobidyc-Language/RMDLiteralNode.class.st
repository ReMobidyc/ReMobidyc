Class {
	#name : #RMDLiteralNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'literal',
		'numeric'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDLiteralNode class >> literal: aString [
	^ self new
		literal: aString;
		yourself
]

{ #category : #comparing }
RMDLiteralNode >> = anObject [
	^ self class = anObject class and: [ literal = anObject literal ]
]

{ #category : #comparing }
RMDLiteralNode >> hash [
	^ literal hash
]

{ #category : #testing }
RMDLiteralNode >> isLiteralNode [
	^ true
]

{ #category : #accessing }
RMDLiteralNode >> literal [
	^ literal
]

{ #category : #accessing }
RMDLiteralNode >> literal: aString [
	literal := aString
]

{ #category : #accessing }
RMDLiteralNode >> numeric [
	^ numeric := literal asNumber
]

{ #category : #accessing }
RMDLiteralNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDLiteralNode >> printOn: aStream [
	aStream nextPutAll: self literal
]
