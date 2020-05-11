Class {
	#name : #RMDCellColorAlphaRenderer,
	#superclass : #RMDCellExpressionRenderer,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellColorAlphaRenderer class >> color: aColor alpha: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ (self
		expression: aRMDExpressionNode
		min: aNumber
		max: anotherNumber)
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDCellColorAlphaRenderer >> color [
	^ color
]

{ #category : #accessing }
RMDCellColorAlphaRenderer >> color: aColor [
	color := aColor
]

{ #category : #defaults }
RMDCellColorAlphaRenderer >> defaultColor [
	^ Color white
]

{ #category : #drawing }
RMDCellColorAlphaRenderer >> drawValue: aNumber bounds: aRectangle on: aCanvas [
	aCanvas
		frameAndFillRectangle: aRectangle
		fillColor: (color alpha: (aNumber min: 1.0 max: 0.0))
		borderWidth: 1
		borderColor: color
]
