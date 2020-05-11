Class {
	#name : #RMDCellColorBrightnessRenderer,
	#superclass : #RMDCellExpressionRenderer,
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

{ #category : #drawing }
RMDCellColorBrightnessRenderer >> drawValue: aNumber bounds: aRectangle on: aCanvas [
	aCanvas
		frameAndFillRectangle: aRectangle
		fillColor:
			(Color
				h: color hue
				s: color saturation
				v: (aNumber min: 1.0 max: 0.005)
				alpha: color alpha)
		borderWidth: 1
		borderColor: color
]

{ #category : #initialization }
RMDCellColorBrightnessRenderer >> initialize [
	super initialize.
	color := self defaultColor
]
