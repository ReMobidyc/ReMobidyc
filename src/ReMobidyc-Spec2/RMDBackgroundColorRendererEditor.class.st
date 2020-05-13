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
				add: 'Background' expand: false;
				add: #colorDropList width: 60)
		height: self inputTextHeight
]

{ #category : #accessing }
RMDBackgroundColorRendererEditor >> preferredHeight [
	^ self class inputTextHeight
]
