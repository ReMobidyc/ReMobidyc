Class {
	#name : #RMDInteractionSpace,
	#superclass : #Object,
	#instVars : [
		'animats',
		'range',
		'xDivisions',
		'yDivisions',
		'divisionWidth',
		'divisionHeight',
		'xs',
		'ys'
	],
	#category : #'ReMobidyc-Interpreter'
}

{ #category : #'instance creation' }
RMDInteractionSpace class >> width: aFloat1 height: aFloat2 range: aFloat3 [

	^ self new
		  width: aFloat1 height: aFloat2 range: aFloat3;
		  yourself
]

{ #category : #adding }
RMDInteractionSpace >> add: anArray x: x y: y [

	| row columnIndex cell |
	cell := (row := animats at: (self yIndexOf: y)) at:
		        (columnIndex := self xIndexOf: x).
	cell ifNil: [ cell := row at: columnIndex put: Set new ].
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
			((animats at: yIndex) at: xIndex) ifNotNil: [ :patch | 
				patch do: [ :animat | 
					((xs at: animat) - x) squared + ((ys at: animat) - y) squared
					<= r2 ifTrue: [ aBlock value: animat ] ] ] ] ]
]

{ #category : #accessing }
RMDInteractionSpace >> maxDivisions [
	^ 1000
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
			((animats at: yIndex) at: xIndex) ifNotNil: [ :cell | 
				cell do: [ :animat | 
					| r2 |
					(r2 := ((xs at: animat) - x) squared
					       + ((ys at: animat) - y) squared) <= minR2 ifTrue: [ 
						minR2 := r2.
						nearest := animat ] ] ] ] ].
	nearest ifNotNil: aBlock
]

{ #category : #private }
RMDInteractionSpace >> width: aFloat1 height: aFloat2 range: aFloat3 [

	range := aFloat3.
	xDivisions := (aFloat1 / range) ceiling min: self maxDivisions.
	yDivisions := (aFloat2 / range) ceiling min: self maxDivisions.
	divisionWidth := aFloat1 / xDivisions asFloat.
	divisionHeight := aFloat2 / yDivisions asFloat.
	animats := (1 to: yDivisions) collect: [ :y | Array new: xDivisions ].
	xs := Dictionary new.
	ys := Dictionary new
]

{ #category : #accessing }
RMDInteractionSpace >> xIndexOf: aFloat [

	^ aFloat // divisionWidth + 1 min: xDivisions max: 1
]

{ #category : #accessing }
RMDInteractionSpace >> yIndexOf: aFloat [

	^ aFloat // divisionHeight + 1 min: yDivisions max: 1
]
