Class {
	#name : #RMDCellRenderer,
	#superclass : #RMDRenderer,
	#category : #'ReMobidyc-Visualization'
}

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
				on: aCanvas ] ]
]

{ #category : #drawing }
RMDCellRenderer >> drawCell: aNumber interpreter: aRMDInterpreter bounds: aRectangle on: aFormCanvas [
	^ self subclassResponsibility
]
