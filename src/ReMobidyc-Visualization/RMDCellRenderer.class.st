Class {
	#name : #RMDCellRenderer,
	#superclass : #RMDRenderer,
	#instVars : [
		'borderWidth',
		'borderColor'
	],
	#category : #'ReMobidyc-Visualization'
}

{ #category : #accessing }
RMDCellRenderer >> borderColor [
	^ borderColor
]

{ #category : #accessing }
RMDCellRenderer >> borderColor: aColor [
	borderColor := aColor
]

{ #category : #accessing }
RMDCellRenderer >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
RMDCellRenderer >> borderWidth: anInteger [
	borderWidth := anInteger
]

{ #category : #defaults }
RMDCellRenderer >> defaultBorderColor [
	^ Color black
]

{ #category : #defaults }
RMDCellRenderer >> defaultBorderWidth [
	^ 2
]

{ #category : #defaults }
RMDCellRenderer >> defaultColor [
	^ Color white
]

{ #category : #drawing }
RMDCellRenderer >> draw: aRMDInterpreter scale: aNumber on: aCanvas [
	| xDivisions yDivisions cellLength |
	xDivisions := aRMDInterpreter cellXDivisions.
	yDivisions := aRMDInterpreter cellYDivisions.
	cellLength := aRMDInterpreter cellLength.
	1 to: yDivisions do: [ :cellY | 
		1 to: xDivisions do: [ :cellX | 
			self
				drawCell: (aRMDInterpreter cellAtXIndex: cellX yIndex: cellY)
				interpreter: aRMDInterpreter
				bounds:
					((self
						pointFromX: (cellX - 1) * cellLength
						y: (cellY - 1) * cellLength
						interpreter: aRMDInterpreter
						scale: aNumber)
						corner:
							(self
								pointFromX: cellX * cellLength
								y: cellY * cellLength
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
RMDCellRenderer >> drawCell: aNumber interpreter: aRMDInterpreter bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]
