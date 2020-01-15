Class {
	#name : #RMDLiteralNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'literal',
		'numeric',
		'type'
	],
	#category : #'ReMobidyc-Language-AST'
}

{ #category : #'instance creation' }
RMDLiteralNode class >> literal: aString type: aRMDTypeNode [
	^ self new
		literal: aString;
		type: aRMDTypeNode;
		yourself
]

{ #category : #comparing }
RMDLiteralNode >> = anObject [
	^ self class = anObject class and: [ literal = anObject literal ]
]

{ #category : #private }
RMDLiteralNode >> computeNumeric [
	^ type toSI: literal asNumber
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
	^ numeric ifNil: [ numeric := self computeNumeric ]
]

{ #category : #accessing }
RMDLiteralNode >> precedence [
	^ 0
]

{ #category : #printing }
RMDLiteralNode >> printOn: aStream [
	aStream nextPutAll: self literal.
	type hasDimension
		ifTrue: [ aStream nextPut: $[.
			type printOn: aStream.
			aStream nextPut: $] ]
]

{ #category : #private }
RMDLiteralNode >> type [
	^ type
]

{ #category : #private }
RMDLiteralNode >> type: aRMDTypeNode [
	type := aRMDTypeNode
]
