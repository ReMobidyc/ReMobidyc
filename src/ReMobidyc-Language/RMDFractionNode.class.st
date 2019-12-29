Class {
	#name : #RMDFractionNode,
	#superclass : #RMDExpressionNode,
	#instVars : [
		'numerator',
		'denominator'
	],
	#category : #'ReMobidyc-Language'
}

{ #category : #'instance creation' }
RMDFractionNode class >> expression: aRMDExpression1 expression: aRMDExpression2 [
	^ self new
		numerator: aRMDExpression1;
		denominator: aRMDExpression2;
		yourself
]

{ #category : #accessing }
RMDFractionNode >> denominator [
	^ denominator
]

{ #category : #accessing }
RMDFractionNode >> denominator: aRMDExpression [
	denominator := aRMDExpression
]

{ #category : #testing }
RMDFractionNode >> isFractionNode [ 
	^ true
]

{ #category : #accessing }
RMDFractionNode >> numerator [
	^ numerator
]

{ #category : #accessing }
RMDFractionNode >> numerator: aRMDExpression [
	numerator := aRMDExpression
]

{ #category : #accessing }
RMDFractionNode >> precedence [
	^ 3
]

{ #category : #printing }
RMDFractionNode >> printOn: aStream [
	self precedence < numerator first precedence
		ifTrue: [ aStream nextPut: $( ].
	numerator first printOn: aStream.
	self precedence < numerator first precedence
		ifTrue: [ aStream nextPut: $) ].
	aStream nextPutAll: '/'.
	self precedence <= denominator precedence
		ifTrue: [ aStream nextPut: $( ].
	denominator printOn: aStream.
	self precedence <= denominator precedence
		ifTrue: [ aStream nextPut: $) ]
]
