Class {
	#name : #RMDInteractionSpaceTest,
	#superclass : #TestCase,
	#instVars : [
		'space'
	],
	#category : #'ReMobidyc-Interpreter-Tests'
}

{ #category : #running }
RMDInteractionSpaceTest >> setUp [

	space := RMDInteractionSpace xdivisions: 5 yDividions: 5 range: 1.5.
	0 to: 5 do: [ :y | 
		0 to: 5 do: [ :x | space add: x @ y x: x asFloat y: y asFloat ] ]
]

{ #category : #tests }
RMDInteractionSpaceTest >> testAnimatsAroundXY [

	self
		assertCollection: (Array streamContents: [ :stream | 
				 space
					 animatsAroundX: 2.0
					 y: 3.0
					 do: [ :animat | stream nextPut: animat ] ])
		hasSameElements: { 
				(1 @ 2).
				(2 @ 2).
				(3 @ 2).
				(1 @ 3).
				(2 @ 3).
				(3 @ 3).
				(1 @ 4).
				(2 @ 4).
				(3 @ 4) }.
	self
		assertCollection: (Array streamContents: [ :stream | 
				 space
					 animatsAroundX: 0.0
					 y: 5.0
					 do: [ :animat | stream nextPut: animat ] ])
		hasSameElements: { 
				(0 @ 4).
				(1 @ 4).
				(0 @ 5).
				(1 @ 5) }
]
