Class {
	#name : #RMDPatchColorAlphaRenderer,
	#superclass : #RMDPatchColorRangeRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDPatchColorAlphaRenderer class >> color: aColor alpha: aRMDExpressionNode between: aRMDLiteralNode1 and: aRMDLiteralNode2 [
	<script:
		'(RMDPatchColorAlphaRenderer color: Color green alpha: ''my grass'' asRMDExpression between: ''0 [kcal]'' asRMDExpression and: ''10000 [kcal]'' asRMDExpression) inspect'>
	^ (self
		expression: aRMDExpressionNode
		min: aRMDLiteralNode1
		max: aRMDLiteralNode2)
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDPatchColorAlphaRenderer >> colorFrom: aNumber [
	^ color alpha: (aNumber min: 1.0 max: 0.0)
]

{ #category : #accessing }
RMDPatchColorAlphaRenderer >> name [
	^ 'color transparency'
]

{ #category : #printing }
RMDPatchColorAlphaRenderer >> printOn: aStream [

	aStream nextPutAll: 'Patch -> '.
	self printColor: color on: aStream.
	aStream nextPutAll: ' with alpha proportional to '.
	expression printOn: aStream.
	aStream nextPutAll: ' between '.
	min printOn: aStream.
	aStream nextPutAll: ' and '.
	max printOn: aStream.
	aStream nextPutAll: 'with '.
	borderWidth asInteger printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColor: borderColor on: aStream.
	aStream nextPutAll: ' grids.'
]
