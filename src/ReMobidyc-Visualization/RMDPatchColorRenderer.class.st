Class {
	#name : #RMDPatchColorRenderer,
	#superclass : #RMDPatchExpressionRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #testing }
RMDPatchColorRenderer class >> isAbstract [

	^ self == RMDPatchColorRenderer
]

{ #category : #accessing }
RMDPatchColorRenderer >> colorFrom: aNumber [
	^ self subclassResponsibility 
]

{ #category : #drawing }
RMDPatchColorRenderer >> drawValue: aNumber bounds: aRectangle on: aCanvas [
	aCanvas fillRectangle: aRectangle color: (self colorFrom: aNumber)
]
