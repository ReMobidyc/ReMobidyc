Class {
	#name : #RMDCellColorBrightnessRendererEditor,
	#superclass : #RMDCellExpressionRendererEditor,
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
				add: '' width: 20;
				add: 'Cells' expand: false;
				add: #colorDropList width: 60;
				add: ' with brightness = ' expand: false;
				add: #expressionField;
				add: '(' expand: false;
				add: #minField width: 100;
				add: '〜' expand: false;
				add: #maxField width: 100;
				add: ')' expand: false;
				yourself)
		height: self inputTextHeight
]
