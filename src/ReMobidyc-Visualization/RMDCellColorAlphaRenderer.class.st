Class {
	#name : #RMDCellColorAlphaRenderer,
	#superclass : #RMDCellExpressionRenderer,
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

{ #category : #drawing }
RMDCellColorAlphaRenderer >> drawValue: aNumber bounds: aRectangle on: aCanvas [
	aCanvas
		frameAndFillRectangle: aRectangle
		fillColor: (color alpha: (aNumber min: 1.0 max: 0.0))
		borderWidth: 1
		borderColor: color
]
