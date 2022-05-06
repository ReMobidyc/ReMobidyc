Class {
	#name : #RMDPatchRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'borderWidth',
		'borderColor'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #comparing }
RMDPatchRenderer >> = anObject [

	^ super = anObject and: [ 
		  borderWidth = anObject borderWidth and: [ 
			  borderColor = anObject borderColor ] ]
]

{ #category : #accessing }
RMDPatchRenderer >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RMDPatchRenderer >> borderColor: aColor [
	borderColor := aColor
]

{ #category : #accessing }
RMDPatchRenderer >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
RMDPatchRenderer >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #defaults }
RMDPatchRenderer >> defaultBorderColor [
	^ Color black
]

{ #category : #defaults }
RMDPatchRenderer >> defaultBorderWidth [
	^ 2
]

{ #category : #defaults }
RMDPatchRenderer >> defaultColor [
	^ Color white
]

{ #category : #drawing }
RMDPatchRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	| xDivisions yDivisions patchLength |
	xDivisions := aRMDInterpreter patchXDivisions.
	yDivisions := aRMDInterpreter patchYDivisions.
	patchLength := aRMDInterpreter patchLength.
	1 to: yDivisions do: [ :patchY | 
		1 to: xDivisions do: [ :patchX | 
			self
				drawPatch: (aRMDInterpreter patchAtXIndex: patchX yIndex: patchY)
				interpreter: aRMDInterpreter
				bounds:
					((self
						pointFromX: (patchX - 1) * patchLength
						y: (patchY - 1) * patchLength
						interpreter: aRMDInterpreter
						scale: aNumber)
						corner:
							(self
								pointFromX: patchX * patchLength
								y: patchY * patchLength
								interpreter: aRMDInterpreter
								scale: aNumber))
				on: aCanvas ] ].
	0 to: xDivisions do: [ :x | 
		aCanvas
			line: (x * aNumber) @ 0
			to: (x * aNumber) @ (yDivisions * aNumber)
			width: borderWidth
			color: borderColor ].
	0 to: yDivisions do: [ :y | 
		aCanvas
			line: 0 @ (y * aNumber)
			to: (xDivisions * aNumber) @ (y * aNumber)
			width: borderWidth
			color: borderColor ]
]

{ #category : #drawing }
RMDPatchRenderer >> drawPatch: aNumber interpreter: aRMDInterpreter bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]

{ #category : #comparing }
RMDPatchRenderer >> hash [

	^ (super hash bitXor: borderWidth hash) bitXor: borderColor hash
]

{ #category : #initialization }
RMDPatchRenderer >> initialize [
	super initialize.
	borderColor := self defaultBorderColor.
	borderWidth := self defaultBorderWidth
]

{ #category : #testing }
RMDPatchRenderer >> isPatchRenderer [
	^ true
]
