Class {
	#name : #RMDBackgroundColorRendererEditor,
	#superclass : #RMDRendererEditor,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDBackgroundColorRendererEditor class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				borderWidth: 5;
				spacing: 5;
				add: '' width: 20;
				add: (SpBoxLayout newVertical addLast: 'Background' expand: false)
					width: 50;
				add: #colorDropList width: 60)
		height: self inputTextHeight
]
