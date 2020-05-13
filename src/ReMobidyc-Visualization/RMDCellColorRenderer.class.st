Class {
	#name : #RMDCellColorRenderer,
	#superclass : #RMDCellExpressionRenderer,
	#instVars : [
		'borderColor',
		'borderWidth'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #accessing }
RMDCellColorRenderer >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RMDCellColorRenderer >> borderColor: aColor [
	borderColor := aColor
]

{ #category : #accessing }
RMDCellColorRenderer >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
RMDCellColorRenderer >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #accessing }
RMDCellColorRenderer >> colorFrom: aNumber [
	^ self subclassResponsibility 
]

{ #category : #defaults }
RMDCellColorRenderer >> defaultBorderColor [
	^ Color black
]

{ #category : #defaults }
RMDCellColorRenderer >> defaultBorderWidth [
	^ 1
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
