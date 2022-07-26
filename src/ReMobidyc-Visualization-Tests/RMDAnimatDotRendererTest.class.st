Class {
	#name : #RMDAnimatDotRendererTest,
	#superclass : #RMDRendererTest,
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #accessing }
RMDAnimatDotRendererTest >> renderer [

	^ RMDAnimatDotRenderer on: 'Turtle' shapeSize: 15 color: Color green
]
