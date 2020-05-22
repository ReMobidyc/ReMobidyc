Class {
	#name : #RMDCellColorRenderer,
	#superclass : #RMDCellExpressionRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #accessing }
RMDCellColorRenderer >> colorFrom: aNumber [
	^ self subclassResponsibility 
]

{ #category : #drawing }
RMDCellColorRenderer >> drawValue: aNumber bounds: aRectangle on: aCanvas [
	aCanvas
		frameAndFillRectangle: aRectangle
		fillColor: (self colorFrom: aNumber)
		borderWidth: borderWidth
		borderColor: borderColor
]

{ #category : #initialization }
RMDCellColorRenderer >> initialize [
	super initialize.
	borderColor := self defaultBorderColor.
	borderWidth := self defaultBorderWidth
]
