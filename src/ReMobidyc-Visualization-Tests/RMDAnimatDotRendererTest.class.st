Class {
	#name : #RMDAnimatDotRendererTest,
	#superclass : #RMDRendererTest,
	#category : #'ReMobidyc-Visualization-Tests'
}

{ #category : #accessing }
RMDAnimatDotRendererTest >> renderer [

	^ RMDAnimatDotRenderer
		  on: 'Turtle'
		  diameter: 15 @ 20
		  color: Color green
]
