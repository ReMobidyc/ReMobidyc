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
	aCanvas fillRectangle: aRectangle color: (self colorFrom: aNumber)
]
