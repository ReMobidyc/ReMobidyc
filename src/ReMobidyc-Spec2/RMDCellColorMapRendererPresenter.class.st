Class {
	#name : #RMDCellColorMapRendererPresenter,
	#superclass : #RMDCellExpressionRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellColorMapRendererPresenter class >> defaultSpec [
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
				borderWidth: 0;
				spacing: 0);
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 0;
				spacing: 0;
				add: '        ' expand: false;
				add: #colorDropList width: 60;
				yourself)
			height: self inputTextHeight
]

{ #category : #initialization }
RMDCellColorMapRendererPresenter >> initializePresenters [
	super initializePresenters.
	self whenBuiltDo: [ self updateSpec ]
]

{ #category : #accessing }
RMDCellColorMapRendererPresenter >> preferredHeight [
	^ (renderer numberOfMinAndColors + 3) * self class inputTextHeight
]

{ #category : #accessing }
RMDCellColorMapRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateSpec
]

{ #category : #updating }
RMDCellColorMapRendererPresenter >> updateSpec [
	| theLayout |
	layout ifNil: [ ^ self ].
	theLayout := layout presenters second.
	renderer
		minAndColorEditorsDo: [ :presenter | 
			theLayout add: presenter height: presenter preferredHeight.
			presenter whenChangedSend: #valueChanged to: self ]
]
