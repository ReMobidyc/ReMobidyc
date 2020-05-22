Class {
	#name : #RMDCellColorMapRendererEditor,
	#superclass : #RMDCellExpressionRendererEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellColorMapRendererEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: 'Cells' expand: false)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newVertical
				borderWidth: 5;
				spacing: 5);
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '        ' expand: false;
				add: #colorDropList width: 60;
				yourself)
			height: self inputTextHeight
]

{ #category : #initialization }
RMDCellColorMapRendererEditor >> initializeWidgets [
	super initializeWidgets.
	self whenBuiltDo: [ self updateSpec ]
]

{ #category : #accessing }
RMDCellColorMapRendererEditor >> preferredHeight [
	^ (renderer numberOfMinAndColors + 2) * self class inputTextHeight
]

{ #category : #accessing }
RMDCellColorMapRendererEditor >> rendererChanged [
	super rendererChanged.
	self updateSpec
]

{ #category : #updating }
RMDCellColorMapRendererEditor >> updateSpec [
	| theLayout |
	layout ifNil: [ ^ self ].
	theLayout := layout presenters second.
	renderer
		minAndColorEditorsDo: [ :editor | theLayout add: editor height: editor preferredHeight ]
]
