Class {
	#name : #RMDCellColorBrightnessRendererEditor,
	#superclass : #RMDCellColorRendererEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDCellColorBrightnessRendererEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: 'Cells' expand: false)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '        ' expand: false;
				add: #colorDropList width: 60;
				add: ' with brightness = ' expand: false;
				add: #expressionField;
				add: '(' expand: false;
				add: #minField width: 100;
				add: '〜' expand: false;
				add: #maxField width: 100;
				add: ') ' expand: false)
			height: self inputTextHeight;
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '        ' expand: false;
				add: #borderColorDropList width: 60;
				add: ' border lines of ' expand: false;
				add: #borderWidthField width: 40;
				add: ' pixels wide.' expand: false;
				yourself)
			height: self inputTextHeight
]

{ #category : #accessing }
RMDCellColorBrightnessRendererEditor >> preferredHeight [
	^ self class inputTextHeight * 3
]
