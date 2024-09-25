Class {
	#name : 'RMDPatchColorMapRendererPresenter',
	#superclass : 'RMDPatchExpressionRendererPresenter',
	#category : 'ReMobidyc-Spec2-Editors',
	#package : 'ReMobidyc-Spec2',
	#tag : 'Editors'
}

{ #category : 'specs' }
RMDPatchColorMapRendererPresenter class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		borderWidth: 0;
		spacing: 0;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: 'Patches' expand: false)
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

{ #category : 'initialization' }
RMDPatchColorMapRendererPresenter >> initializePresenters [
	super initializePresenters.
	self whenBuiltDo: [ self updateSpec ]
]

{ #category : 'accessing' }
RMDPatchColorMapRendererPresenter >> preferredHeight [
	^ (renderer numberOfMinAndColors + 3) * self class inputTextHeight
]

{ #category : 'accessing' }
RMDPatchColorMapRendererPresenter >> rendererChanged [
	super rendererChanged.
	self updateSpec
]

{ #category : 'updating' }
RMDPatchColorMapRendererPresenter >> updateSpec [
	| theLayout |
	layout ifNil: [ ^ self ].
	theLayout := layout presenters second.
	renderer
		minAndColorEditorsDo: [ :presenter | 
			theLayout add: presenter height: presenter preferredHeight.
			presenter whenChangedSend: #valueChanged to: self ]
]
