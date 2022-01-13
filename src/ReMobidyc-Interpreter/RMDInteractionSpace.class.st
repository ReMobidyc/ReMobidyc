Class {
	#name : #RMDInteractionSpace,
	#superclass : #Object,
	#instVars : [
		'animats',
		'range',
		'xDivisions',
		'yDivisions',
		'xs',
		'ys'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDInteractionSpace class >> xdivisions: anInteger1 yDividions: anInteger2 range: aFloat [

	^ self new
		  xDivisions: anInteger1 yDividions: anInteger2 range: aFloat;
		  yourself
]

{ #category : #adding }
RMDInteractionSpace >> add: anArray x: x y: y [

	| cell |
	cell := (animats at: (self yIndexOf: y)) at: (self xIndexOf: x).
	cell add: anArray.
	xs at: anArray put: x.
	ys at: anArray put: y.
	^ anArray
]

{ #category : #enumerating }
RMDInteractionSpace >> animatsAroundX: x y: y do: aBlock [

	| xIndex0 yIndex0 r2 |
	xIndex0 := self xIndexOf: x.
	yIndex0 := self yIndexOf: y.
	r2 := range squared.
	(yIndex0 - 1 max: 1) to: (yIndex0 + 1 min: yDivisions) do: [ :yIndex | 
		(xIndex0 - 1 max: 1) to: (xIndex0 + 1 min: xDivisions) do: [ :xIndex | 
			((animats at: yIndex) at: xIndex) do: [ :animat | 
				((xs at: animat) - x) squared + ((ys at: animat) - y) squared
				<= r2 ifTrue: [ aBlock value: animat ] ] ] ]
]

{ #category : #enumerating }
RMDInteractionSpace >> nearestAnimatAroundX: x y: y do: aBlock [

	| xIndex0 yIndex0 minR2 nearest |
	xIndex0 := self xIndexOf: x.
	yIndex0 := self yIndexOf: y.
	minR2 := range squared.
	nearest := nil.
	(yIndex0 - 1 max: 1) to: (yIndex0 + 1 min: yDivisions) do: [ :yIndex | 
		(xIndex0 - 1 max: 1) to: (xIndex0 + 1 min: xDivisions) do: [ :xIndex | 
			((animats at: yIndex) at: xIndex) do: [ :animat | 
				| r2 |
				(r2 := ((xs at: animat) - x) squared
				       + ((ys at: animat) - y) squared) <= minR2 ifTrue: [ 
					minR2 := r2.
					nearest := animat ] ] ] ].
	nearest ifNotNil: aBlock
]

{ #category : #private }
RMDInteractionSpace >> xDivisions: anInteger1 yDividions: anInteger2 range: aFloat [

	xDivisions := anInteger1.
	yDivisions := anInteger2.
	range := aFloat.
	animats := (1 to: yDivisions) collect: [ :y | 
		           (1 to: xDivisions) collect: [ :x | Set new: 256 ] ].
	xs := Dictionary new.
	ys := Dictionary new
]

{ #category : #accessing }
RMDInteractionSpace >> xIndexOf: aFloat [

	^ aFloat // range + 1 min: xDivisions max: 0
]

{ #category : #accessing }
RMDInteractionSpace >> yIndexOf: aFloat [

	^ aFloat // range + 1 min: yDivisions max: 1
]
