Class {
	#name : #RMDCellColorAlphaRenderer,
	#superclass : #RMDCellColorRangeRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellColorAlphaRenderer class >> color: aColor alpha: aRMDExpressionNode between: aRMDLiteralNode1 and: aRMDLiteralNode2 [
	<script:
		'(RMDCellColorAlphaRenderer color: Color green alpha: ''my grass'' asRMDExpression between: ''0 [kcal]'' asRMDExpression and: ''10000 [kcal]'' asRMDExpression) inspect'>
	^ (self
		expression: aRMDExpressionNode
		min: aRMDLiteralNode1
		max: aRMDLiteralNode2)
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDCellColorAlphaRenderer >> colorFrom: aNumber [
	^ color alpha: (aNumber min: 1.0 max: 0.0)
]

{ #category : #accessing }
RMDCellColorAlphaRenderer >> name [
	^ 'color transparency'
]

{ #category : #printing }
RMDCellColorAlphaRenderer >> printOn: aStream [

	aStream nextPutAll: 'Cell -> alpha proportional to '.
	expression printOn: aStream.
	aStream nextPutAll: ' between '.
	min printOn: aStream.
	aStream nextPutAll: ' and '.
	max printOn: aStream.
	aStream nextPut: Character cr
]
