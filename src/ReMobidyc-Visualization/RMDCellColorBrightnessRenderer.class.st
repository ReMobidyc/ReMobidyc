Class {
	#name : #RMDCellColorBrightnessRenderer,
	#superclass : #RMDCellRenderer,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

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
RMDCellColorBrightnessRenderer >> drawValue: aNumber bounds: aRectangle on: aFormCanvas [
	aFormCanvas
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
