Class {
	#name : #RMDBackgroundColorRendererPresenter,
	#superclass : #RMDRendererPresenter,
	#category : #'ReMobidyc-Spec2-Editors'
}

{ #category : #layout }
RMDBackgroundColorRendererPresenter class >> defaultLayout [
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

{ #category : #api }
RMDBackgroundColorRendererPresenter >> disableAgentFields [
	
]

{ #category : #api }
RMDBackgroundColorRendererPresenter >> enableAgentFields [
]

{ #category : #accessing }
RMDBackgroundColorRendererPresenter >> preferredHeight [
	^ self class inputTextHeight
]
