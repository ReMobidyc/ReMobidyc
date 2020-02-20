Class {
	#name : #RMDCellColorBrightnessRenderer,
	#superclass : #RMDCellRenderer,
	#instVars : [
		'color'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #drawing }
RMDCellColorBrightnessRenderer >> drawValue: aNumber bounds: aRectangle on: aFormCanvas [
	aFormCanvas
		fillRectangle: aRectangle
		color: (color adjustBrightness: aNumber)
]
