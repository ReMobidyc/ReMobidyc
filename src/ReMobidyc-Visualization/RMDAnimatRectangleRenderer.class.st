Class {
	#name : #RMDAnimatRectangleRenderer,
	#superclass : #RMDAnimatShapeRenderer,
	#category : #'ReMobidyc-Visualization'
}

{ #category : #drawing }
RMDAnimatRectangleRenderer >> drawIndividual: anInteger with: aRMDInterpreter at: aPoint on: aCanvas [

	aCanvas
		fillRectangle:
		(Rectangle center: aPoint extent: self shapeSize asPoint)
		color: self color
]

{ #category : #accessing }
RMDAnimatRectangleRenderer >> name [
	^ 'rectangle renderer'
]

{ #category : #printing }
RMDAnimatRectangleRenderer >> printOn: aStream [

	aStream
		nextPutAll: animat;
		nextPutAll: ' -> '.
	shapeSize printOn: aStream.
	aStream nextPutAll: ' pixels '.
	self printColorOn: aStream.
	aStream nextPutAll: ' rectangle.'.
	aStream cr
]
