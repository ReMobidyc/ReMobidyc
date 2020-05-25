Class {
	#name : #RMDBackgroundColorRendererPresenter,
	#superclass : #RMDRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #specs }
RMDBackgroundColorRendererPresenter class >> defaultSpec [
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
RMDBackgroundColorRendererPresenter >> preferredHeight [
	^ self class inputTextHeight
]
