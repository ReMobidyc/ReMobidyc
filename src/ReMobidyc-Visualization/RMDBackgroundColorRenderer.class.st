Class {
	#name : #RMDBackgroundColorRenderer,
	#superclass : #RMDBackgroundRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> black [
	^ self color: Color black
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> blue [
	^ self color: Color blue
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> color: aColor [
	^ self new
		color: aColor;
		yourself
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> red [
	^ self color: Color red
]

{ #category : #'instance creation' }
RMDBackgroundColorRenderer class >> white [
	^ self color: Color white
]

{ #category : #drawing }
RMDBackgroundColorRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [

	| xDivisions yDivisions |
	xDivisions := aRMDInterpreter simulationModel patchXDivisions.
	yDivisions := aRMDInterpreter simulationModel patchYDivisions.
	aCanvas
		fillRectangle: (0 @ 0 extent:
				 (aNumber * xDivisions) ceiling @ (aNumber * yDivisions) ceiling)
		color: color
]

{ #category : #testing }
RMDBackgroundColorRenderer >> isPatchRenderer [
	^ true
]

{ #category : #accessing }
RMDBackgroundColorRenderer >> name [
	^ 'background color'
]

{ #category : #printing }
RMDBackgroundColorRenderer >> printOn: aStream [

	aStream nextPutAll: 'World -> '.
	self printColorOn: aStream.
	aStream
		nextPut: $.;
		cr
]
