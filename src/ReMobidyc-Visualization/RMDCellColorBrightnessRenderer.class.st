Class {
	#name : #RMDCellColorBrightnessRenderer,
	#superclass : #RMDCellExpressionRenderer,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDCellColorBrightnessRenderer class >> color: aColor brightness: aRMDExpressionNode between: aNumber and: anotherNumber [
	^ (self
		expression: aRMDExpressionNode
		min: aNumber
		max: anotherNumber)
		color: aColor;
		yourself
]

{ #category : #accessing }
RMDCellColorBrightnessRenderer >> color [
	^ color
]

{ #category : #accessing }
RMDCellColorBrightnessRenderer >> color: aColor [
	color := aColor
]

{ #category : #defaults }
RMDCellColorBrightnessRenderer >> defaultColor [
	^ Color white
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
