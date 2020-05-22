Class {
	#name : #RMDCellColorBrightnessRenderer,
	#superclass : #RMDCellColorRangeRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellColorBrightnessRenderer class >> color: aColor brightness: aRMDExpressionNode between: aRMDLiteralNode1 and: aRMDLiteralNode2 [
	<script:
		'(RMDCellColorBrightnessRenderer color: Color green brightness: ''my grass'' asRMDExpression between: ''0 [kcal]'' asRMDExpression and: ''10000 [kcal]'' asRMDExpression) inspect'>
	^ (self
		expression: aRMDExpressionNode
		min: aRMDLiteralNode1
		max: aRMDLiteralNode2)
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDCellColorBrightnessRenderer >> colorFrom: aNumber [
	^ Color
		h: color hue
		s: color saturation
		v: (aNumber min: 1.0 max: 0.005)
		alpha: color alpha
]
