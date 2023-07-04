Extension { #name : #DataFrame }

{ #category : #'*ReMobidyc-DataSource' }
DataFrame >> forceNumericOrNil [

	1 to: self numberOfRows do: [ :rowIndex |
		1 to: self numberOfColumns do: [ :columnIndex |
			self at: rowIndex at: columnIndex transform: [ :v |
				[ v asNumber ]
					on: Error
					do: [ :ex | nil ] ] ] ]
]
